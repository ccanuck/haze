# Plugins, Cache, Metrics, and Database

## Plugins

Plugins are lifecycle modules that receive framework context.

```swift
import Plugins

struct ModerationPlugin: Plugin {
    let metadata = PluginMetadata(name: "Moderation", version: "1.0.0")

    func setup(context: PluginContext) async throws {
    }
}
```

Load with:

```swift
try await client.loadPlugin(ModerationPlugin())
```

## Cache

`CacheManager` provides actor-safe in-memory stores:

- guilds
- channels
- users
- members
- messages

Configure policy with:

- `maxEntries`
- eviction mode (`none`, `fifo`, `lru`)
- global enable/disable flag

## Metrics

`MetricsSink` defines:

- counter increments
- timing measurements

`InMemoryMetrics` is included for local development and tests.

## Database

`DatabaseManager` supports optional drivers:

- PostgreSQL
- SQLite
- Redis
- MongoDB

Implement `DatabaseDriver` for each backend and register it with `DatabaseManager`.
