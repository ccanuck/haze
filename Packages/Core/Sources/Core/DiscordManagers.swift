import Foundation
import Builders
import REST

public struct DiscordUser: Decodable, Sendable {
    public let id: String
    public let username: String
    public let discriminator: String?
}

public struct DiscordChannel: Decodable, Sendable {
    public let id: String
    public let type: Int?
    public let name: String?
}

public struct DiscordMessageResponse: Decodable, Sendable {
    public let id: String
    public let channelID: String
    public let content: String

    enum CodingKeys: String, CodingKey {
        case id
        case channelID = "channel_id"
        case content
    }
}

public actor UserManager {
    private let restProvider: @Sendable () async throws -> RESTClient

    public init(restProvider: @escaping @Sendable () async throws -> RESTClient) {
        self.restProvider = restProvider
    }

    public func fetch(_ userID: String) async throws -> DiscordUser {
        let rest = try await restProvider()
        return try await rest.send(DiscordRoutes.user(userID), as: DiscordUser.self)
    }
}

public actor ChannelManager {
    private let restProvider: @Sendable () async throws -> RESTClient

    public init(restProvider: @escaping @Sendable () async throws -> RESTClient) {
        self.restProvider = restProvider
    }

    public func fetch(_ channelID: String) async throws -> DiscordChannel {
        let rest = try await restProvider()
        return try await rest.send(DiscordRoutes.channel(channelID), as: DiscordChannel.self)
    }
}

public actor MessageManager {
    private let restProvider: @Sendable () async throws -> RESTClient

    public init(restProvider: @escaping @Sendable () async throws -> RESTClient) {
        self.restProvider = restProvider
    }

    public func send(channelID: String, content: String) async throws -> DiscordMessageResponse {
        struct CreateMessageRequest: Encodable {
            let content: String
        }
        let rest = try await restProvider()
        return try await rest.send(
            DiscordRoutes.channelMessages(channelID),
            body: CreateMessageRequest(content: content),
            as: DiscordMessageResponse.self
        )
    }

    public func send(channelID: String, message: MessageBuilder) async throws -> DiscordMessageResponse {
        struct CreateMessageRequest: Encodable {
            let content: String?
            let embeds: [Embed]
            let components: [ActionRow<MessageComponent>]
        }
        let rest = try await restProvider()
        return try await rest.send(
            DiscordRoutes.channelMessages(channelID),
            body: CreateMessageRequest(content: message.content, embeds: message.embeds, components: message.components),
            as: DiscordMessageResponse.self
        )
    }
}
