import Foundation
import Commands
import Interactions
import Cache

public struct PluginMetadata: Sendable {
    public let name: String
    public let version: String
    public let dependencies: [String]

    public init(name: String, version: String, dependencies: [String] = []) {
        self.name = name
        self.version = version
        self.dependencies = dependencies
    }
}

public struct PluginContext: Sendable {
    public let commands: CommandRegistry
    public let interactions: InteractionRouter
    public let cache: CacheManager

    public init(commands: CommandRegistry, interactions: InteractionRouter, cache: CacheManager) {
        self.commands = commands
        self.interactions = interactions
        self.cache = cache
    }
}

public protocol Plugin: Sendable {
    var metadata: PluginMetadata { get }
    func setup(context: PluginContext) async throws
    func teardown(context: PluginContext) async
}

public extension Plugin {
    func teardown(context: PluginContext) async {}
}
