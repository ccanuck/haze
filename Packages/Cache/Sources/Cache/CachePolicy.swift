import Foundation

public enum EvictionPolicy: String, Sendable, Codable {
    case none
    case lru
    case fifo
}

public struct CachePolicy: Sendable, Codable {
    public let maxEntries: Int?
    public let eviction: EvictionPolicy
    public let isEnabled: Bool

    public init(maxEntries: Int? = nil, eviction: EvictionPolicy = .none, isEnabled: Bool = true) {
        self.maxEntries = maxEntries
        self.eviction = eviction
        self.isEnabled = isEnabled
    }
}
