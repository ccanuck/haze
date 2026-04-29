import Foundation

public enum DatabaseBackend: String, Sendable, Codable {
    case postgresql
    case sqlite
    case redis
    case mongodb
}

public struct DatabaseConfiguration: Sendable {
    public let backend: DatabaseBackend
    public let connectionString: String

    public init(backend: DatabaseBackend, connectionString: String) {
        self.backend = backend
        self.connectionString = connectionString
    }
}

public protocol DatabaseDriver: Sendable {
    var backend: DatabaseBackend { get }
    func connect(configuration: DatabaseConfiguration) async throws
    func disconnect() async
}

public actor DatabaseManager {
    private var drivers: [DatabaseBackend: any DatabaseDriver] = [:]

    public init() {}

    public func register(_ driver: any DatabaseDriver) {
        drivers[driver.backend] = driver
    }

    public func connect(_ configuration: DatabaseConfiguration) async throws {
        guard let driver = drivers[configuration.backend] else { return }
        try await driver.connect(configuration: configuration)
    }

    public func disconnectAll() async {
        for driver in drivers.values {
            await driver.disconnect()
        }
    }
}
