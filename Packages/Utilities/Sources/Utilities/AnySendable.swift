import Foundation

public struct AnySendable: Sendable {
    public let value: any Sendable

    public init(_ value: any Sendable) {
        self.value = value
    }
}
