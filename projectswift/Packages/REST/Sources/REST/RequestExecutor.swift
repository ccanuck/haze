import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public struct RequestExecutor: Sendable {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func execute(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw RESTError.serverError(statusCode: -1, body: "Non-HTTP response")
        }
        return (data, httpResponse)
    }
}
