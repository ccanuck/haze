import Foundation

public actor InteractionCollector {
    public struct Configuration: Sendable {
        public let timeout: Duration
        public let maxEvents: Int?

        public init(timeout: Duration = .seconds(60), maxEvents: Int? = nil) {
            self.timeout = timeout
            self.maxEvents = maxEvents
        }
    }

    private let filter: @Sendable (Interaction) -> Bool
    private let configuration: Configuration
    private var count = 0
    private var isClosed = false
    private var continuation: AsyncStream<Interaction>.Continuation?
    private var timeoutTask: Task<Void, Never>?

    public init(
        configuration: Configuration = Configuration(),
        filter: @escaping @Sendable (Interaction) -> Bool
    ) {
        self.configuration = configuration
        self.filter = filter
    }

    deinit {
        timeoutTask?.cancel()
    }

    public func stream() -> AsyncStream<Interaction> {
        AsyncStream { continuation in
            self.continuation = continuation
            self.timeoutTask = Task { [configuration] in
                try? await Task.sleep(for: configuration.timeout)
                await self.close()
            }
        }
    }

    public func consume(_ interaction: Interaction) {
        guard !isClosed else { return }
        guard filter(interaction) else { return }
        continuation?.yield(interaction)
        count += 1
        if let maxEvents = configuration.maxEvents, count >= maxEvents {
            close()
        }
    }

    public func close() {
        guard !isClosed else { return }
        isClosed = true
        timeoutTask?.cancel()
        timeoutTask = nil
        continuation?.finish()
    }
}
