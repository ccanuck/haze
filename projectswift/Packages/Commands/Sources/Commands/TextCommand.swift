import Foundation
import Models

public struct TextCommandMessage: Sendable {
    public let message: Message
    public let prefix: String

    public init(message: Message, prefix: String) {
        self.message = message
        self.prefix = prefix
    }
}

public struct TextCommandContext: Sendable {
    public let message: Message
    public let commandName: String
    public let args: [String]
    private let replyHandler: @Sendable (String) async throws -> Void

    public init(
        message: Message,
        commandName: String,
        args: [String],
        replyHandler: @escaping @Sendable (String) async throws -> Void
    ) {
        self.message = message
        self.commandName = commandName
        self.args = args
        self.replyHandler = replyHandler
    }

    public func reply(_ content: String) async throws {
        try await replyHandler(content)
    }
}

public protocol TextCommand: Sendable {
    static var name: String { get }
    static var aliases: [String] { get }
    static var description: String { get }
    func execute(context: TextCommandContext) async throws
}

public extension TextCommand {
    static var aliases: [String] { [] }
}

public struct AnyTextCommand: Sendable {
    public let name: String
    public let aliases: [String]
    public let description: String
    public let execute: @Sendable (TextCommandContext) async throws -> Void

    public init<C: TextCommand>(_ command: C) {
        self.name = C.name
        self.aliases = C.aliases
        self.description = C.description
        self.execute = { context in
            try await command.execute(context: context)
        }
    }
}
