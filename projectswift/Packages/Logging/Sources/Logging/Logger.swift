import Foundation

public protocol Logger: Sendable {
    func log(_ level: LogLevel, message: String, metadata: [String: String]) async
}

public actor ConsoleLogger: Logger {
    public init() {}

    public func log(_ level: LogLevel, message: String, metadata: [String: String] = [:]) async {
        let metadataText = metadata
            .sorted(by: { $0.key < $1.key })
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: " ")

        if metadataText.isEmpty {
            print("[\(level.rawValue.uppercased())] \(message)")
        } else {
            print("[\(level.rawValue.uppercased())] \(message) \(metadataText)")
        }
    }
}
