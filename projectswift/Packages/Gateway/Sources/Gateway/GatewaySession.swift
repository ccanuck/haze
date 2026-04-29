import Foundation

public struct GatewaySession: Sendable {
    public var sessionID: String?
    public var resumeURL: URL?
    public var sequence: Int?

    public init(sessionID: String? = nil, resumeURL: URL? = nil, sequence: Int? = nil) {
        self.sessionID = sessionID
        self.resumeURL = resumeURL
        self.sequence = sequence
    }
}
