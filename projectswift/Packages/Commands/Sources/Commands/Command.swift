import Foundation
import Interactions

public protocol Command: Sendable {
    static var name: String { get }
    static var description: String { get }
    static var metadata: CommandMetadata { get }
    func execute(context: CommandContext) async throws
}

public extension Command {
    static var description: String { "" }
    static var metadata: CommandMetadata { CommandMetadata(kind: .slash) }
}

public struct AnyCommand: Sendable {
    public let name: String
    public let description: String
    public let metadata: CommandMetadata
    public let checks: [CommandCheck]
    public let cooldownSeconds: TimeInterval?
    public let execute: @Sendable (CommandContext) async throws -> Void

    public init<C: Command>(
        _ command: C,
        checks: [CommandCheck] = [],
        cooldownSeconds: TimeInterval? = nil
    ) {
        self.name = C.name
        self.description = C.description
        self.metadata = C.metadata
        self.checks = checks
        self.cooldownSeconds = cooldownSeconds
        self.execute = { context in
            try await command.execute(context: context)
        }
    }
}
