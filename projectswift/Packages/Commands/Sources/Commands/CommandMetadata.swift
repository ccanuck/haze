import Foundation

public enum CommandKind: String, Sendable, Codable {
    case slash
    case text
    case hybrid
}

public struct CommandOptionChoice: Sendable, Codable {
    public let name: String
    public let value: String

    public init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}

public struct CommandOption: Sendable, Codable {
    public let name: String
    public let description: String
    public let required: Bool
    public let autocomplete: Bool
    public let choices: [CommandOptionChoice]

    public init(
        name: String,
        description: String,
        required: Bool = false,
        autocomplete: Bool = false,
        choices: [CommandOptionChoice] = []
    ) {
        self.name = name
        self.description = description
        self.required = required
        self.autocomplete = autocomplete
        self.choices = choices
    }
}

public struct CommandMetadata: Sendable, Codable {
    public let kind: CommandKind
    public let options: [CommandOption]
    public let aliases: [String]
    public let dmPermission: Bool
    public let defaultMemberPermissions: String?

    public init(
        kind: CommandKind = .slash,
        options: [CommandOption] = [],
        aliases: [String] = [],
        dmPermission: Bool = true,
        defaultMemberPermissions: String? = nil
    ) {
        self.kind = kind
        self.options = options
        self.aliases = aliases
        self.dmPermission = dmPermission
        self.defaultMemberPermissions = defaultMemberPermissions
    }
}
