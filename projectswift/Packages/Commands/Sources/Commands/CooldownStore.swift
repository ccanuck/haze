import Foundation

public actor CooldownStore {
    private var entries: [String: Date] = [:]

    public init() {}

    public func checkAndSet(key: String, cooldown: TimeInterval) throws {
        let now = Date()
        if let expiry = entries[key], expiry > now {
            throw CommandError.cooldownActive(retryAfterSeconds: expiry.timeIntervalSince(now))
        }
        entries[key] = now.addingTimeInterval(cooldown)
    }
}
