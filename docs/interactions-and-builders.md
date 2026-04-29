# Interactions and Builders

## Interaction types

`Interactions` currently models:

- application commands
- message components
- modal submissions

Register handlers:

```swift
await client.onInteraction("ticket_create") { interaction in
    print("Interaction \(interaction.name) in channel \(interaction.channelID ?? "unknown")")
}
```

## Components

Build action rows and components with `Builders`.

```swift
import Builders

let button = Button(style: .primary, label: "Confirm", customID: "confirm")
let row = ActionRow<MessageComponent>([.button(button)])
```

## Components v2-ready structure

Use `MessageBuilder.componentVersion`:

- `.v1` for current layout
- `.v2` for newer component payload shape as the transport layer evolves

## Embeds

```swift
let embed = Embed(
    title: "Status",
    description: "All systems operational",
    color: 0x57F287,
    fields: [
        EmbedField(name: "Region", value: "us-east", inline: true),
        EmbedField(name: "Shard", value: "0", inline: true)
    ]
)
```

## Full message payload

```swift
let message = MessageBuilder(
    content: "Deployment complete",
    embeds: [embed],
    components: [row],
    componentVersion: .v1
)
```
