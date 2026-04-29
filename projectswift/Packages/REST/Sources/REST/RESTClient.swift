import Foundation
import Logging

public actor RESTClient {
    private let baseURL: URL
    private let token: String
    private let limiter: RateLimiter
    private let queue: RequestQueue
    private let executor: RequestExecutor
    private let logger: any Logger
    private let retryPolicy: RESTRetryPolicy
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    public init(
        baseURL: URL = URL(string: "https://discord.com/api/v10")!,
        token: String,
        limiter: RateLimiter = RateLimiter(),
        queue: RequestQueue = RequestQueue(),
        executor: RequestExecutor = RequestExecutor(),
        retryPolicy: RESTRetryPolicy = RESTRetryPolicy(),
        logger: any Logger
    ) {
        self.baseURL = baseURL
        self.token = token
        self.limiter = limiter
        self.queue = queue
        self.executor = executor
        self.logger = logger
        self.retryPolicy = retryPolicy
        self.encoder = JSONEncoder()
        self.decoder = JSONDecoder()
    }

    public func send<Response: Decodable>(
        _ route: Route,
        body: (any Encodable)? = nil,
        as: Response.Type
    ) async throws -> Response {
        let data = try await send(route, body: body)
        guard !data.isEmpty else { throw RESTError.decodeFailure }
        return try decoder.decode(Response.self, from: data)
    }

    public func send(_ route: Route, body: (any Encodable)? = nil) async throws -> Data {
        let bucket = "\(route.method.rawValue):\(route.path)"
        return try await queue.enqueue(bucket: bucket) { [self] in
            try await executeWithRetry(route: route, body: body, bucket: bucket)
        }
    }

    public func sendVoid(_ route: Route, body: (any Encodable)? = nil) async throws {
        _ = try await send(route, body: body)
    }

    private func executeWithRetry(
        route: Route,
        body: (any Encodable)?,
        bucket: String
    ) async throws -> Data {
        var attempt = 0
        var lastStatus = -1
        var lastBody = ""

        while true {
            await limiter.waitIfNeeded(bucket: bucket)
            let request = try makeRequest(route: route, body: body)

            await logger.log(.debug, message: "REST request", metadata: [
                "method": route.method.rawValue,
                "path": route.path,
                "attempt": "\(attempt)"
            ])

            let (data, response) = try await executor.execute(request)
            lastStatus = response.statusCode
            lastBody = String(data: data, encoding: .utf8) ?? ""

            if let retryAfter = response.value(forHTTPHeaderField: "Retry-After").flatMap(TimeInterval.init) {
                await limiter.update(bucket: bucket, retryAfter: retryAfter)
            } else {
                await limiter.update(bucket: bucket, retryAfter: nil)
            }

            if (200..<300).contains(response.statusCode) {
                return data
            }

            let shouldRetry = retryPolicy.retryableStatusCodes.contains(response.statusCode) && attempt < retryPolicy.maxRetries
            guard shouldRetry else {
                throw RESTError.serverError(statusCode: response.statusCode, body: lastBody)
            }

            attempt += 1
            let delayMs = retryPolicy.nextDelayMs(retryIndex: attempt - 1)
            await logger.log(.warning, message: "REST retrying request", metadata: [
                "method": route.method.rawValue,
                "path": route.path,
                "status": "\(response.statusCode)",
                "attempt": "\(attempt)",
                "delay_ms": "\(delayMs)"
            ])
            try? await Task.sleep(nanoseconds: delayMs * 1_000_000)

            if attempt > retryPolicy.maxRetries {
                throw RESTError.retryExhausted(lastStatusCode: lastStatus, body: lastBody)
            }
        }
    }

    private func makeRequest(route: Route, body: (any Encodable)?) throws -> URLRequest {
        guard let url = URL(string: route.path, relativeTo: baseURL) else {
            throw RESTError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = route.method.rawValue
        request.setValue("Bot \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let body {
            request.httpBody = try encodeAny(body)
        }
        return request
    }

    private func encodeAny(_ value: any Encodable) throws -> Data {
        let wrapped = AnyEncodable(value)
        return try encoder.encode(wrapped)
    }
}

private struct AnyEncodable: Encodable {
    private let encodeClosure: (Encoder) throws -> Void

    init(_ base: any Encodable) {
        self.encodeClosure = { encoder in
            try base.encode(to: encoder)
        }
    }

    func encode(to encoder: Encoder) throws {
        try encodeClosure(encoder)
    }
}
