import Foundation
import Models

public struct EventContext: Sendable {
    public private(set) var isCancelled: Bool = false

    public init() {}

    public mutating func cancel() {
        isCancelled = true
    }
}

public typealias EventMiddleware = @Sendable (any DiscordEvent, inout EventContext) async throws -> Void

public actor EventBus {
    private struct HandlerEntry: Sendable {
        let call: @Sendable (any DiscordEvent) async throws -> Void
    }

    private var handlers: [ObjectIdentifier: [HandlerEntry]] = [:]
    private var middleware: [EventMiddleware] = []

    public init() {}

    public func use(_ middleware: @escaping EventMiddleware) {
        self.middleware.append(middleware)
    }

    public func on<E: DiscordEvent>(
        _ type: E.Type,
        handler: @escaping @Sendable (E) async throws -> Void
    ) {
        let key = ObjectIdentifier(type)
        let entry = HandlerEntry { event in
            guard let typed = event as? E else { return }
            try await handler(typed)
        }
        handlers[key, default: []].append(entry)
    }

    public func emit<E: DiscordEvent>(_ event: E) async throws {
        var context = EventContext()
        for step in middleware {
            try await step(event, &context)
            if context.isCancelled {
                return
            }
        }

        let key = ObjectIdentifier(E.self)
        for handler in handlers[key, default: []] {
            try await handler.call(event)
        }
    }
}
