import Foundation

public struct GatewayReconnectPolicy: Sendable {
    public let maxAttempts: Int
    public let baseDelayMs: UInt64
    public let maxDelayMs: UInt64

    public init(maxAttempts: Int = 20, baseDelayMs: UInt64 = 500, maxDelayMs: UInt64 = 30_000) {
        self.maxAttempts = max(1, maxAttempts)
        self.baseDelayMs = max(50, baseDelayMs)
        self.maxDelayMs = max(baseDelayMs, maxDelayMs)
    }

    public func delayMs(forAttempt attempt: Int) -> UInt64 {
        let boundedAttempt = min(attempt, 16)
        let raw = baseDelayMs * (1 << UInt64(boundedAttempt))
        return min(raw, maxDelayMs)
    }
}
