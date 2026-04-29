# Haze <img src="https://img.shields.io/github/v/release/ccanuck/haze?label=Version&color=blue">
<p align="center">
  <img src="https://img.shields.io/badge/Swift-FA7343?logo=swift&logoColor=white">
  <img src="https://img.shields.io/badge/License-Apache_2.0-blue">
  <img src="https://img.shields.io/badge/Platform-macOS%20%7C%20Linux-blue">
  <img src="https://img.shields.io/badge/Windows-Supported-0078D6?logo=windows&logoColor=white">
  <img src="https://img.shields.io/badge/Discord-5865F2?logo=discord&logoColor=white">
</p>
Haze is a modular Discord framework for Swift with async/await-first APIs.

## Documentation

- [Getting Started](docs/getting-started.md)
- [Architecture](docs/architecture.md)
- [Commands Guide](docs/commands.md)
- [Interactions and Builders](docs/interactions-and-builders.md)
- [Gateway and REST](docs/gateway-and-rest.md)
- [Plugins, Cache, Metrics, Database](docs/plugins-cache-metrics-database.md)
- [Roadmap](docs/roadmap.md)

## Current Status

- Modular Swift Package Manager architecture
- Async/await-first `DiscordClient`
- Strongly typed event system
- Gateway subsystem scaffolding (shard-ready actors)
- REST subsystem scaffolding (routes, rate limiter, request execution pipeline)
- Command framework baseline (registry, context, cooldown store)
- Slash + text command architecture (with command metadata and aliases)
- Interaction router and component builders
- Embed + components message builder support (v1 and v2-ready component model)
- Slash command payload export and global sync service
- Collector API for interaction streams with filter/timeout control
- Manager-style REST APIs for users/channels/messages
- Generic middleware pipeline
- Actor-safe cache abstractions
- Plugin manager and lifecycle contracts
- Metrics and database integration abstractions

## Package Layout

- `Packages/Core`
- `Packages/Gateway`
- `Packages/REST`
- `Packages/Models`
- `Packages/Utilities`
- `Packages/Logging`
- `Packages/Commands`
- `Packages/Interactions`
- `Packages/Cache`
- `Packages/Plugins`
- `Packages/Middleware`
- `Packages/Builders`
- `Packages/Metrics`
- `Packages/Database`
