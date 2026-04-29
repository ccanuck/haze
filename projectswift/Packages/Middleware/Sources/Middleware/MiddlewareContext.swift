import Foundation

public struct MiddlewareContext: Sendable {
    public private(set) var isCancelled: Bool = false
    public var metadata: [String: String]

    public init(metadata: [String: String] = [:]) {
        self.metadata = metadata
    }

    public mutating func cancel() {
        isCancelled = true
    }
}
