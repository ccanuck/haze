import Foundation

public enum GatewayConnectionState: Sendable, Equatable {
    case idle
    case connecting
    case identifying
    case connected
    case resuming
    case reconnecting(attempt: Int)
    case disconnected(reason: String?)
}
