import Foundation
import Commands
import REST

public actor CommandSyncService {
    private let applicationID: String
    private let commandRegistry: CommandRegistry
    private let restProvider: @Sendable () async throws -> RESTClient

    public init(
        applicationID: String,
        commandRegistry: CommandRegistry,
        restProvider: @escaping @Sendable () async throws -> RESTClient
    ) {
        self.applicationID = applicationID
        self.commandRegistry = commandRegistry
        self.restProvider = restProvider
    }

    public func syncGlobalCommands() async throws {
        let payload = await commandRegistry.exportSlashPayloads()
        let rest = try await restProvider()
        try await rest.sendVoid(DiscordRoutes.applicationCommands(applicationID: applicationID), body: payload)
    }
}
