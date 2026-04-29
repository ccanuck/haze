import Foundation

public struct Route: Sendable, Hashable {
    public enum Method: String, Sendable {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }

    public let method: Method
    public let path: String

    public init(method: Method, path: String) {
        self.method = method
        self.path = path
    }
}
