import Foundation

public actor RateLimiter {
    private var nextAvailableAt: [String: Date] = [:]

    public init() {}

    public func waitIfNeeded(bucket: String) async {
        guard let availableAt = nextAvailableAt[bucket] else { return }

        let delay = availableAt.timeIntervalSinceNow
        if delay > 0 {
            let nanoseconds = UInt64(delay * 1_000_000_000)
            try? await Task.sleep(nanoseconds: nanoseconds)
        }
    }

    public func update(bucket: String, retryAfter: TimeInterval?) {
        guard let retryAfter, retryAfter > 0 else {
            nextAvailableAt[bucket] = nil
            return
        }
        nextAvailableAt[bucket] = Date().addingTimeInterval(retryAfter)
    }
}
