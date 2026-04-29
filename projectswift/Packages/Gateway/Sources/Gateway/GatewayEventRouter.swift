import Foundation
import Models

public protocol GatewayEventRouter: Sendable {
    func route<E: DiscordEvent>(_ event: E) async
}
