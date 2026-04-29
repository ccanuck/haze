import Foundation

public struct RESTRetryPolicy: Sendable {
    public let maxRetries: Int
    public let baseDelayMs: UInt64
    public let maxDelayMs: UInt64
    public let retryableStatusCodes: Set<Int>

    public init(
        maxRetries: Int = 4,
        baseDelayMs: UInt64 = 250,
        maxDelayMs: UInt64 = 8_000,
        retryableStatusCodes: Set<Int> = [429, 500, 502, 503, 504]
    ) {
        self.maxRetries = max(0, maxRetries)
        self.baseDelayMs = max(50, baseDelayMs)
        self.maxDelayMs = max(baseDelayMs, maxDelayMs)
        self.retryableStatusCodes = retryableStatusCodes
    }

    public func nextDelayMs(retryIndex: Int) -> UInt64 {
        let bounded = min(max(0, retryIndex), 16)
        let raw = baseDelayMs * (1 << UInt64(bounded))
        return min(raw, maxDelayMs)
    }
}
