import Foundation
import Models

public actor CacheManager {
    public let users: MemoryCache<Snowflake, Snowflake>
    public let channels: MemoryCache<Snowflake, Snowflake>
    public let guilds: MemoryCache<Snowflake, Snowflake>
    public let members: MemoryCache<String, Snowflake>
    public let messages: MemoryCache<Snowflake, Message>

    public init(policy: CachePolicy = CachePolicy(maxEntries: 10_000, eviction: .lru, isEnabled: true)) {
        self.users = MemoryCache(policy: policy)
        self.channels = MemoryCache(policy: policy)
        self.guilds = MemoryCache(policy: policy)
        self.members = MemoryCache(policy: policy)
        self.messages = MemoryCache(policy: policy)
    }
}
