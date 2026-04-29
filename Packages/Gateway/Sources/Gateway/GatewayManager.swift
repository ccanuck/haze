import Foundation
import Logging
import Models

public actor GatewayManager {
    public private(set) var shards: [Int: Shard] = [:]

    private let configuration: GatewayConfiguration
    private let logger: any Logger
    private let router: any GatewayEventRouter

    public init(
        configuration: GatewayConfiguration,
        logger: any Logger,
        router: any GatewayEventRouter
    ) {
        self.configuration = configuration
        self.logger = logger
        self.router = router
    }

    public func start() async {
        guard shards.isEmpty else { return }
        await logger.log(.info, message: "Starting gateway manager", metadata: [
            "shard_count": "\(configuration.shardCount)"
        ])

        for id in 0..<configuration.shardCount {
            let shard = Shard(id: id, configuration: configuration, logger: logger, router: router)
            shards[id] = shard
            await shard.connect()
        }
    }

    public func stop() async {
        for shard in shards.values {
            await shard.disconnect(reason: "shutdown")
        }
        shards.removeAll()
        await logger.log(.info, message: "Gateway manager stopped", metadata: [:])
    }

    public func reconnectShard(_ id: Int, reason: String? = nil) async {
        guard let shard = shards[id] else { return }
        await shard.requestReconnect(reason: reason)
    }
}
