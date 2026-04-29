import Foundation

public enum ClientError: Error, Sendable {
    case alreadyRunning
    case notRunning
}
