import Foundation
import Interactions
import Middleware

public actor CommandRegistry {
    public typealias CommandMiddleware = MiddlewarePipeline<Interaction>.Middleware

    private var commands: [String: AnyCommand] = [:]
    private let pipeline = MiddlewarePipeline<Interaction>()
    private let cooldownStore = CooldownStore()
    private let responder: any CommandResponder

    public init(responder: any CommandResponder) {
        self.responder = responder
    }

    public func use(_ middleware: @escaping CommandMiddleware) async {
        await pipeline.use(middleware)
    }

    public func register<C: Command>(
        _ command: C,
        checks: [CommandCheck] = [],
        cooldownSeconds: TimeInterval? = nil
    ) {
        commands[C.name] = AnyCommand(command, checks: checks, cooldownSeconds: cooldownSeconds)
    }

    public func unregister(name: String) {
        commands[name] = nil
    }

    public func allCommands() -> [AnyCommand] {
        commands.values.sorted { $0.name < $1.name }
    }

    public func exportSlashPayloads() -> [SlashCommandPayload] {
        allCommands()
            .filter { $0.metadata.kind == .slash || $0.metadata.kind == .hybrid }
            .map { command in
                let options = command.metadata.options.map { option in
                    SlashCommandOption(
                        type: SlashOptionType.string.rawValue,
                        name: option.name,
                        description: option.description,
                        required: option.required,
                        autocomplete: option.autocomplete,
                        choices: option.choices.map { SlashCommandChoice(name: $0.name, value: $0.value) }
                    )
                }
                return SlashCommandPayload(
                    name: command.name,
                    description: command.description.isEmpty ? command.name : command.description,
                    dmPermission: command.metadata.dmPermission,
                    defaultMemberPermissions: command.metadata.defaultMemberPermissions,
                    options: options
                )
            }
    }

    public func execute(interaction: Interaction) async throws {
        let context = try await pipeline.run(interaction, metadata: ["command": interaction.name])
        guard !context.isCancelled else { return }
        guard let command = commands[interaction.name] else { return }

        for check in command.checks {
            try await check(interaction)
        }
        if let cooldownSeconds = command.cooldownSeconds {
            let key = "\(command.name):\(interaction.id)"
            try await cooldownStore.checkAndSet(key: key, cooldown: cooldownSeconds)
        }

        let commandContext = CommandContext(interaction: interaction, responder: responder)
        try await command.execute(commandContext)
    }
}
