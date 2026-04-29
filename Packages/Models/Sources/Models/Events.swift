import Foundation

public protocol DiscordEvent: Sendable {
    static var name: String { get }
}

public extension DiscordEvent {
    static var name: String { String(describing: Self.self) }
}

public struct ReadyEvent: DiscordEvent {
    public let sessionID: String
    public let shardIndex: Int

    public init(sessionID: String, shardIndex: Int) {
        self.sessionID = sessionID
        self.shardIndex = shardIndex
    }
}

public struct MessageCreateEvent: DiscordEvent {
    public let message: Message

    public init(message: Message) {
        self.message = message
    }
}
