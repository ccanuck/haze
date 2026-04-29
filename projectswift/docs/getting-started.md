# Getting Started

## Requirements

- Swift 6+
- macOS or Windows
- Discord bot token

## Add ProjectSwift as a dependency

Use one of these:

- Local path dependency while developing:

```swift
.package(path: "../projectswift")
```

- Git dependency after publishing:

```swift
.package(url: "https://github.com/your-org/ProjectSwift.git", from: "0.1.0")
```

Add products to your executable target:

```swift
.product(name: "Core", package: "ProjectSwift"),
.product(name: "Commands", package: "ProjectSwift"),
.product(name: "Builders", package: "ProjectSwift")
```

## Minimal bot

```swift
import Core
import Models

@main
struct BotApp {
    static func main() async throws {
        let config = ClientConfiguration(
            token: ProcessInfo.processInfo.environment["DISCORD_TOKEN"] ?? "",
            intents: [.guilds, .guildMessages, .messageContent],
            shardCount: 1
        )

        let client = DiscordClient(configuration: config)

        await client.on(MessageCreateEvent.self) { event in
            print("Message: \(event.message.content)")
        }

        try await client.login()
        try await Task.never()
    }
}
```

## Next steps

- Register slash commands in `Commands`
- Register text commands for prefix flows
- Use `Builders` for embeds and components
- Add plugins and cache policies for production
