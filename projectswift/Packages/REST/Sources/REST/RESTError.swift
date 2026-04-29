import Foundation

public enum RESTError: Error, Sendable {
    case invalidURL
    case serverError(statusCode: Int, body: String)
    case decodeFailure
    case retryExhausted(lastStatusCode: Int, body: String)
}
