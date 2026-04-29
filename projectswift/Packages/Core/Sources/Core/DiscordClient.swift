import Foundation
import Builders
import Cache
import Commands
import Database
import Gateway
import Interactions
import Logging
import Metrics
import Models
import Plugins
import REST

public actor DiscordClient {
    private let configuration: ClientConfiguration
    private let logger: any Logger
    private let eventBus: EventBus

    private var gatewayManager: GatewayManager?
    private var restClient: RESTClient?
    private let interactionRouter: InteractionRouter
    private let commandRegistry: CommandRegistry
    private let textCommandRegistry: TextCommandRegistry
    private let cacheManager: CacheManager
    private let pluginManager: PluginManager
    private let metrics: any MetricsSink
    private let database: DatabaseManager
    private var running = false

    public init(
        configuration: ClientConfiguration,
        logger: any Logger = ConsoleLogger(),
        eventBus: EventBus = EventBus(),
        metrics: any MetricsSink = InMemoryMetrics(),
        database: DatabaseManager = DatabaseManager()
    ) {
        self.configuration = configuration
        self.logger = logger
        self.eventBus = eventBus
        self.interactionRouter = InteractionRouter()
        self.cacheManager = CacheManager()
        self.commandRegistry = CommandRegistry(responder: DiscordCommandResponder(logger: logger))
        self.textCommandRegistry = TextCommandRegistry(
            sendMessage: { channelID, content in
                await logger.log(.info, message: "Text reply", metadata: [
                    "channel_id": channelID.rawValue,
                    "content": content
                ])
            }
        )
        self.pluginManager = PluginManager(
            context: PluginContext(commands: commandRegistry, interactions: interactionRouter, cache: cacheManager)
        )
        self.metrics = metrics
        self.database = database
    }

    public func on<E: DiscordEvent>(
        _ eventType: E.Type,
        handler: @escaping @Sendable (E) async throws -> Void
    ) async {
        await eventBus.on(eventType, handler: handler)
    }

    public func useEventMiddleware(_ middleware: @escaping EventMiddleware) async {
        await eventBus.use(middleware)
    }

    public func login() async throws {
        guard !running else { throw ClientError.alreadyRunning }
        running = true

        let rest = RESTClient(token: configuration.token, logger: logger)
        restClient = rest

        let gatewayConfiguration = GatewayConfiguration(
            token: configuration.token,
            intents: configuration.intents,
            shardCount: configuration.shardCount
        )
        let gateway = GatewayManager(configuration: gatewayConfiguration, logger: logger, router: self)
        gatewayManager = gateway

        await logger.log(.info, message: "Discord client starting", metadata: [
            "shards": "\(configuration.shardCount)"
        ])
        await metrics.incrementCounter("client.start", by: 1, labels: [:])
        await gateway.start()
    }

    public func shutdown() async throws {
        guard running else { throw ClientError.notRunning }
        running = false

        await gatewayManager?.stop()
        await pluginManager.unloadAll()
        await database.disconnectAll()
        gatewayManager = nil
        restClient = nil

        await logger.log(.info, message: "Discord client stopped", metadata: [:])
        await metrics.incrementCounter("client.stop", by: 1, labels: [:])
    }

    public func register<C: Command>(_ command: C) async {
        await commandRegistry.register(command)
    }

    public func register<C: TextCommand>(_ command: C) async {
        await textCommandRegistry.register(command)
    }

    public func onInteraction(
        _ name: String,
        handler: @escaping @Sendable (Interaction) async throws -> Void
    ) async {
        await interactionRouter.register(name: name, handler: handler)
    }

    public func handleInteraction(_ interaction: Interaction) async throws {
        let clock = ContinuousClock()
        let start = clock.now
        switch interaction.type {
        case .applicationCommand:
            try await commandRegistry.execute(interaction: interaction)
        default:
            try await interactionRouter.route(interaction)
        }
        let duration = start.duration(to: clock.now)
        let ms = Double(duration.components.seconds) * 1_000 + Double(duration.components.attoseconds) / 1_000_000_000_000_000
        await metrics.recordTiming("interaction.handle", durationMs: ms, labels: ["type": "\(interaction.type)"])
    }

    public func loadPlugin(_ plugin: any Plugin) async throws {
        try await pluginManager.load(plugin)
    }

    public func usersManager() -> UserManager {
        UserManager(restProvider: {
            try await self.requireREST()
        })
    }

    public func channelsManager() -> ChannelManager {
        ChannelManager(restProvider: {
            try await self.requireREST()
        })
    }

    public func messagesManager() -> MessageManager {
        MessageManager(restProvider: {
            try await self.requireREST()
        })
    }

    public func syncGlobalCommands() async throws {
        guard let applicationID = configuration.applicationID else { return }
        let service = CommandSyncService(
            applicationID: applicationID,
            commandRegistry: commandRegistry,
            restProvider: { [weak self] in
                guard let self else { throw ClientError.notRunning }
                guard let rest = await self.restClient else { throw ClientError.notRunning }
                return rest
            }
        )
        try await service.syncGlobalCommands()
    }

    public func createInteractionCollector(
        configuration: InteractionCollector.Configuration = .init(),
        filter: @escaping @Sendable (Interaction) -> Bool
    ) async -> (id: UUID, stream: AsyncStream<Interaction>) {
        await interactionRouter.createCollector(configuration: configuration, filter: filter)
    }

    public func removeInteractionCollector(id: UUID) async {
        await interactionRouter.removeCollector(id: id)
    }

    private func requireREST() throws -> RESTClient {
        guard let restClient else {
            throw ClientError.notRunning
        }
        return restClient
    }
}

extension DiscordClient: GatewayEventRouter {
    public nonisolated func route<E: DiscordEvent>(_ event: E) async {
        Task {
            if let messageEvent = event as? MessageCreateEvent {
                try? await self.textCommandRegistry.handle(message: messageEvent.message)
            }
            try? await self.eventBus.emit(event)
        }
    }
}

private struct DiscordCommandResponder: CommandResponder {
    let logger: any Logger

    func reply(interaction: Interaction, content: String) async throws {
        await logger.log(.info, message: "Reply", metadata: [
            "interaction_id": interaction.id,
            "content": content
        ])
    }

    func reply(interaction: Interaction, message: MessageBuilder) async throws {
        await logger.log(.info, message: "Reply builder", metadata: [
            "interaction_id": interaction.id,
            "content": message.content ?? "",
            "embeds": "\(message.embeds.count)",
            "components": "\(message.components.count)",
            "components_version": message.componentVersion.rawValue
        ])
    }
}
