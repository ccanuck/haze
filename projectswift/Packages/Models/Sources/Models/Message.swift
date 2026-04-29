import Foundation

public struct Message: Codable, Hashable, Sendable {
    public let id: Snowflake
    public let channelID: Snowflake
    public let authorID: Snowflake
    public let content: String

    public init(id: Snowflake, channelID: Snowflake, authorID: Snowflake, content: String) {
        self.id = id
        self.channelID = channelID
        self.authorID = authorID
        self.content = content
    }
}
