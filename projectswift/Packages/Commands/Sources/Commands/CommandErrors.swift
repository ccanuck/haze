import Foundation

public enum CommandError: Error, Sendable {
    case duplicateCommand(name: String)
    case cooldownActive(retryAfterSeconds: TimeInterval)
    case permissionDenied
    case checkFailed(reason: String)
}
