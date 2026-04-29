import Foundation

public actor RequestQueue {
    private struct BucketChain {
        let id: UUID
        let task: Task<Data, Error>
    }

    private var bucketChains: [String: BucketChain] = [:]

    public init() {}

    public func enqueue(
        bucket: String,
        operation: @escaping @Sendable () async throws -> Data
    ) async throws -> Data {
        let previous = bucketChains[bucket]?.task
        let chainID = UUID()
        let task = Task<Data, Error> {
            if let previous {
                _ = try? await previous.value
            }
            return try await operation()
        }
        bucketChains[bucket] = BucketChain(id: chainID, task: task)

        defer {
            if bucketChains[bucket]?.id == chainID {
                bucketChains[bucket] = nil
            }
        }

        return try await task.value
    }
}
