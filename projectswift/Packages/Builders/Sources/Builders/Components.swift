import Foundation

public enum ComponentVersion: String, Sendable, Codable {
    case v1
    case v2
}

public enum ButtonStyle: String, Sendable, Codable {
    case primary
    case secondary
    case success
    case danger
    case link
}

public struct Button: Sendable, Codable {
    public let style: ButtonStyle
    public let label: String
    public let customID: String?

    public init(style: ButtonStyle, label: String, customID: String? = nil) {
        self.style = style
        self.label = label
        self.customID = customID
    }
}

public struct StringSelectOption: Sendable, Codable {
    public let label: String
    public let value: String
    public let description: String?

    public init(label: String, value: String, description: String? = nil) {
        self.label = label
        self.value = value
        self.description = description
    }
}

public struct StringSelectMenu: Sendable, Codable {
    public let customID: String
    public let placeholder: String?
    public let options: [StringSelectOption]

    public init(customID: String, placeholder: String? = nil, options: [StringSelectOption]) {
        self.customID = customID
        self.placeholder = placeholder
        self.options = options
    }
}

public enum MessageComponent: Sendable, Codable {
    case button(Button)
    case stringSelect(StringSelectMenu)
}

public struct ActionRow<Component: Sendable & Codable>: Sendable, Codable {
    public let components: [Component]

    public init(_ components: [Component]) {
        self.components = components
    }
}

public struct EmbedField: Sendable, Codable {
    public let name: String
    public let value: String
    public let inline: Bool

    public init(name: String, value: String, inline: Bool = false) {
        self.name = name
        self.value = value
        self.inline = inline
    }
}

public struct Embed: Sendable, Codable {
    public let title: String?
    public let description: String?
    public let color: Int?
    public let fields: [EmbedField]

    public init(title: String? = nil, description: String? = nil, color: Int? = nil, fields: [EmbedField] = []) {
        self.title = title
        self.description = description
        self.color = color
        self.fields = fields
    }
}

public struct MessageBuilder: Sendable, Codable {
    public var content: String?
    public var embeds: [Embed]
    public var components: [ActionRow<MessageComponent>]
    public var componentVersion: ComponentVersion

    public init(
        content: String? = nil,
        embeds: [Embed] = [],
        components: [ActionRow<MessageComponent>] = [],
        componentVersion: ComponentVersion = .v1
    ) {
        self.content = content
        self.embeds = embeds
        self.components = components
        self.componentVersion = componentVersion
    }

    public static func text(_ content: String) -> MessageBuilder {
        MessageBuilder(content: content)
    }
}
