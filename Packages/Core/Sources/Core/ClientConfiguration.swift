import Foundation
import Models

public struct ClientConfiguration: Sendable {
    public let token: String
    public let intents: Intents
    public let shardCount: Int
    public let applicationID: String?

    public init(
        token: String,
        intents: Intents = .all,
        shardCount: Int = 1,
        applicationID: String? = nil
    ) {
        self.token = token
        self.intents = intents
        self.shardCount = max(shardCount, 1)
        self.applicationID = applicationID
    }
}
