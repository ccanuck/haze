# Architecture Overview

ProjectSwift follows a modular architecture with clear package boundaries and async/await-first APIs.

## Design Principles

- Protocol-oriented design and composition
- Actor isolation for shared mutable state
- Strongly typed public APIs
- Dependency injection over global state

## Implemented Foundation Modules

- `Core`: `DiscordClient`, typed event bus, startup lifecycle
- `Gateway`: shard-ready manager and connection state model
- `REST`: route model, rate limiter actor, request execution pipeline
- `Commands`: command protocol, context, registry, cooldown store
- `Interactions`: typed interaction models and async router
- `Middleware`: reusable actor-based middleware pipeline
- `Builders`: typed component builders (including `Button`)
- `Cache`: actor-safe in-memory cache with configurable policy
- `Plugins`: plugin protocol, metadata, lifecycle-aware manager
- `Metrics`: sink protocol and in-memory metrics collector
- `Database`: optional backend abstraction and driver registry
- `Models`: shared protocol and domain models
- `Logging`: structured logger abstraction
- `Utilities`: shared low-level helpers

## Planned Extensions

- Gateway heartbeat/session resume/reconnect internals
- REST retry policy, bucket hashing, multipart upload support
- Macro-backed slash command annotations and registration
- Full interaction components and collectors
- Production drivers for PostgreSQL, SQLite, Redis, and MongoDB
