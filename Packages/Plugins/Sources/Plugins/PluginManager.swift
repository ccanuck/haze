import Foundation

public actor PluginManager {
    private var loaded: [String: any Plugin] = [:]
    private let context: PluginContext

    public init(context: PluginContext) {
        self.context = context
    }

    public func load(_ plugin: any Plugin) async throws {
        let name = plugin.metadata.name
        if loaded[name] != nil {
            return
        }
        try await plugin.setup(context: context)
        loaded[name] = plugin
    }

    public func unload(name: String) async {
        guard let plugin = loaded.removeValue(forKey: name) else { return }
        await plugin.teardown(context: context)
    }

    public func unloadAll() async {
        let names = loaded.keys.sorted()
        for name in names {
            await unload(name: name)
        }
    }

    public func loadedPlugins() -> [PluginMetadata] {
        loaded.values.map(\.metadata).sorted { $0.name < $1.name }
    }
}
