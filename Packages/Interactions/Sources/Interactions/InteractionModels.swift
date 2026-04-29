import Foundation

public enum InteractionType: Sendable, Codable {
    case applicationCommand
    case messageComponent
    case modalSubmit
}

public struct Interaction: Sendable, Codable {
    public let id: String
    public let type: InteractionType
    public let name: String
    public let token: String
    public let channelID: String?
    public let guildID: String?

    public init(
        id: String,
        type: InteractionType,
        name: String,
        token: String,
        channelID: String? = nil,
        guildID: String? = nil
    ) {
        self.id = id
        self.type = type
        self.name = name
        self.token = token
        self.channelID = channelID
        self.guildID = guildID
    }
}
