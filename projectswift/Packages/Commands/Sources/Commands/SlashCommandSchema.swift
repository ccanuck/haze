import Foundation

public enum SlashOptionType: Int, Sendable, Codable {
    case subcommand = 1
    case subcommandGroup = 2
    case string = 3
    case integer = 4
    case boolean = 5
    case user = 6
    case channel = 7
    case role = 8
    case mentionable = 9
    case number = 10
    case attachment = 11
}

public struct SlashCommandChoice: Sendable, Codable {
    public let name: String
    public let value: String

    public init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}

public struct SlashCommandOption: Sendable, Codable {
    public let type: Int
    public let name: String
    public let description: String
    public let required: Bool?
    public let autocomplete: Bool?
    public let choices: [SlashCommandChoice]?
    public let options: [SlashCommandOption]?

    public init(
        type: Int,
        name: String,
        description: String,
        required: Bool? = nil,
        autocomplete: Bool? = nil,
        choices: [SlashCommandChoice]? = nil,
        options: [SlashCommandOption]? = nil
    ) {
        self.type = type
        self.name = name
        self.description = description
        self.required = required
        self.autocomplete = autocomplete
        self.choices = choices
        self.options = options
    }
}

public struct SlashCommandPayload: Sendable, Codable {
    public let name: String
    public let description: String
    public let dmPermission: Bool
    public let defaultMemberPermissions: String?
    public let options: [SlashCommandOption]

    public init(
        name: String,
        description: String,
        dmPermission: Bool,
        defaultMemberPermissions: String?,
        options: [SlashCommandOption]
    ) {
        self.name = name
        self.description = description
        self.dmPermission = dmPermission
        self.defaultMemberPermissions = defaultMemberPermissions
        self.options = options
    }
}
