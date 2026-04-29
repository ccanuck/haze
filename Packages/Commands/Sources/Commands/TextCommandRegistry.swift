import Foundation
import Models

public actor TextCommandRegistry {
    private var byName: [String: AnyTextCommand] = [:]
    private let prefix: String
    private let sendMessage: @Sendable (Snowflake, String) async throws -> Void

    public init(
        prefix: String = "!",
        sendMessage: @escaping @Sendable (Snowflake, String) async throws -> Void
    ) {
        self.prefix = prefix
        self.sendMessage = sendMessage
    }

    public func register<C: TextCommand>(_ command: C) {
        let wrapped = AnyTextCommand(command)
        byName[wrapped.name.lowercased()] = wrapped
        for alias in wrapped.aliases {
            byName[alias.lowercased()] = wrapped
        }
    }

    public func handle(message: Message) async throws {
        guard message.content.hasPrefix(prefix) else { return }
        let raw = String(message.content.dropFirst(prefix.count))
        let parts = raw.split(separator: " ").map(String.init)
        guard let commandName = parts.first?.lowercased() else { return }
        guard let command = byName[commandName] else { return }

        let args = Array(parts.dropFirst())
        let context = TextCommandContext(
            message: message,
            commandName: commandName,
            args: args,
            replyHandler: { [sendMessage] content in
                try await sendMessage(message.channelID, content)
            }
        )
        try await command.execute(context)
    }
}
