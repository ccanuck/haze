import Foundation
import Middleware

public actor InteractionRouter {
    public typealias Handler = @Sendable (Interaction) async throws -> Void

    private let pipeline = MiddlewarePipeline<Interaction>()
    private var handlers: [String: Handler] = [:]
    private var collectors: [UUID: InteractionCollector] = [:]

    public init() {}

    public func use(_ middleware: @escaping MiddlewarePipeline<Interaction>.Middleware) async {
        await pipeline.use(middleware)
    }

    public func register(name: String, handler: @escaping Handler) {
        handlers[name] = handler
    }

    public func route(_ interaction: Interaction) async throws {
        let context = try await pipeline.run(interaction, metadata: ["interaction_name": interaction.name])
        guard !context.isCancelled else { return }
        for collector in collectors.values {
            await collector.consume(interaction)
        }
        guard let handler = handlers[interaction.name] else { return }
        try await handler(interaction)
    }

    public func createCollector(
        configuration: InteractionCollector.Configuration = .init(),
        filter: @escaping @Sendable (Interaction) -> Bool
    ) -> (id: UUID, stream: AsyncStream<Interaction>) {
        let id = UUID()
        let collector = InteractionCollector(configuration: configuration, filter: filter)
        collectors[id] = collector
        return (id, collector.stream())
    }

    public func removeCollector(id: UUID) async {
        guard let collector = collectors.removeValue(forKey: id) else { return }
        await collector.close()
    }
}
