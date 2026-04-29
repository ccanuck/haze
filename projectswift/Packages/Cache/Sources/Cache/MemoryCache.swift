import Foundation

public actor MemoryCache<Key: Hashable & Sendable, Value: Sendable> {
    private struct Entry: Sendable {
        var value: Value
        var insertedAt: Date
        var touchedAt: Date
    }

    private var storage: [Key: Entry] = [:]
    private let policy: CachePolicy

    public init(policy: CachePolicy = CachePolicy()) {
        self.policy = policy
    }

    public func set(_ value: Value, for key: Key) {
        guard policy.isEnabled else { return }
        let now = Date()
        storage[key] = Entry(value: value, insertedAt: now, touchedAt: now)
        evictIfNeeded()
    }

    public func get(_ key: Key) -> Value? {
        guard var entry = storage[key] else { return nil }
        entry.touchedAt = Date()
        storage[key] = entry
        return entry.value
    }

    public func remove(_ key: Key) {
        storage.removeValue(forKey: key)
    }

    private func evictIfNeeded() {
        guard let maxEntries = policy.maxEntries, storage.count > maxEntries else { return }
        guard policy.eviction != .none else { return }

        let candidate = storage.min { lhs, rhs in
            switch policy.eviction {
            case .fifo:
                return lhs.value.insertedAt < rhs.value.insertedAt
            case .lru:
                return lhs.value.touchedAt < rhs.value.touchedAt
            case .none:
                return false
            }
        }
        if let key = candidate?.key {
            storage.removeValue(forKey: key)
        }
    }
}
