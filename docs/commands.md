# Commands Guide

ProjectSwift supports both interaction-based and prefix-based commands.

## Slash-style commands

```swift
import Commands

struct PingCommand: Command {
    static let name = "ping"
    static let description = "Check latency"
    static let metadata = CommandMetadata(
        kind: .slash,
        options: [],
        aliases: []
    )

    func execute(context: CommandContext) async throws {
        try await context.reply("Pong!")
    }
}
```

Register in the client:

```swift
await client.register(PingCommand())
```

## Text commands

```swift
import Commands

struct EchoTextCommand: TextCommand {
    static let name = "echo"
    static let aliases = ["say"]
    static let description = "Echo text"

    func execute(context: TextCommandContext) async throws {
        let output = context.args.joined(separator: " ")
        try await context.reply(output.isEmpty ? "Nothing to echo." : output)
    }
}
```

Register in the client:

```swift
await client.register(EchoTextCommand())
```

## Checks and cooldowns

Attach checks and cooldowns at registration time with `CommandRegistry` directly.

- `BuiltinChecks.guildOnly()` blocks command usage outside guilds
- `cooldownSeconds` throttles repeated usage

## Replying with rich messages

`CommandContext.reply(_:)` supports:

- plain text (`String`)
- `MessageBuilder` payloads with embeds and components
