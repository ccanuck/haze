import Foundation

public actor MiddlewarePipeline<Input: Sendable> {
    public typealias Middleware = @Sendable (Input, inout MiddlewareContext) async throws -> Void

    private var handlers: [Middleware] = []

    public init() {}

    public func use(_ middleware: @escaping Middleware) {
        handlers.append(middleware)
    }

    public func run(_ input: Input, metadata: [String: String] = [:]) async throws -> MiddlewareContext {
        var context = MiddlewareContext(metadata: metadata)
        for handler in handlers {
            try await handler(input, &context)
            if context.isCancelled {
                break
            }
        }
        return context
    }
}
