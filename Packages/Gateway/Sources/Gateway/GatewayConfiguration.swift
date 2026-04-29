import Foundation
import Models

public struct GatewayConfiguration: Sendable {
    public let token: String
    public let intents: Intents
    public let shardCount: Int
    public let gatewayURL: URL
    public let heartbeatIntervalMs: UInt64
    public let reconnectPolicy: GatewayReconnectPolicy

    public init(
        token: String,
        intents: Intents,
        shardCount: Int = 1,
        gatewayURL: URL = URL(string: "wss://gateway.discord.gg/?v=10&encoding=json")!,
        heartbeatIntervalMs: UInt64 = 41_250,
        reconnectPolicy: GatewayReconnectPolicy = GatewayReconnectPolicy()
    ) {
        self.token = token
        self.intents = intents
        self.shardCount = max(shardCount, 1)
        self.gatewayURL = gatewayURL
        self.heartbeatIntervalMs = heartbeatIntervalMs
        self.reconnectPolicy = reconnectPolicy
    }
}
