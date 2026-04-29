import Foundation

public struct Intents: OptionSet, Codable, Sendable {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let guilds = Intents(rawValue: 1 << 0)
    public static let guildMessages = Intents(rawValue: 1 << 9)
    public static let directMessages = Intents(rawValue: 1 << 12)
    public static let messageContent = Intents(rawValue: 1 << 15)
    public static let all: Intents = [.guilds, .guildMessages, .directMessages, .messageContent]
}
