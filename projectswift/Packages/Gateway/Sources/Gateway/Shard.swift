import Foundation
import Logging
import Models

public actor Shard {
    public let id: Int
    public private(set) var state: GatewayConnectionState = .idle

    private let configuration: GatewayConfiguration
    private let logger: any Logger
    private let router: (any GatewayEventRouter)?
    private var session = GatewaySession()
    private var reconnectAttempts = 0
    private var heartbeatTask: Task<Void, Never>?
    private var isStopping = false
    private var hasHeartbeatACK = true

    public init(
        id: Int,
        configuration: GatewayConfiguration,
        logger: any Logger,
        router: (any GatewayEventRouter)?
    ) {
        self.id = id
        self.configuration = configuration
        self.logger = logger
        self.router = router
    }

    public func connect() async {
        heartbeatTask?.cancel()
        heartbeatTask = nil
        isStopping = false
        state = .connecting
        await logger.log(.info, message: "Shard connecting", metadata: ["shard_id": "\(id)"])

        state = .connected
        reconnectAttempts = 0
        session.sessionID = session.sessionID ?? "pending-session-\(id)"
        session.sequence = 0
        hasHeartbeatACK = true
        startHeartbeatLoop()
        await router?.route(ReadyEvent(sessionID: session.sessionID ?? "unknown", shardIndex: id))
    }

    public func disconnect(reason: String?) async {
        isStopping = true
        heartbeatTask?.cancel()
        heartbeatTask = nil
        state = .disconnected(reason: reason)
        await logger.log(.warning, message: "Shard disconnected", metadata: [
            "shard_id": "\(id)",
            "reason": reason ?? "unknown"
        ])
    }

    public func updateSequence(_ sequence: Int) {
        session.sequence = sequence
    }

    public func receive(_ payload: GatewayPayload) async {
        if let sequence = payload.s {
            updateSequence(sequence)
        }

        switch payload.op {
        case .dispatch:
            await handleDispatch(payload)
        case .hello:
            hasHeartbeatACK = true
        case .heartbeatACK:
            hasHeartbeatACK = true
        case .reconnect:
            await requestReconnect(reason: "gateway_reconnect_opcode")
        case .invalidSession:
            session.sessionID = nil
            await requestReconnect(reason: "invalid_session")
        case .heartbeat:
            await sendHeartbeat()
        default:
            break
        }
    }

    public func requestReconnect(reason: String?) async {
        guard !isStopping else { return }

        reconnectAttempts += 1
        let attempt = reconnectAttempts
        state = .reconnecting(attempt: attempt)
        await logger.log(.warning, message: "Shard reconnect requested", metadata: [
            "shard_id": "\(id)",
            "attempt": "\(attempt)",
            "reason": reason ?? "unknown"
        ])

        guard attempt <= configuration.reconnectPolicy.maxAttempts else {
            await disconnect(reason: "max_reconnect_attempts_exceeded")
            return
        }

        let delayMs = configuration.reconnectPolicy.delayMs(forAttempt: attempt - 1)
        try? await Task.sleep(nanoseconds: delayMs * 1_000_000)

        if session.sessionID != nil {
            state = .resuming
        }
        await connect()
    }

    private func startHeartbeatLoop() {
        let interval = max(configuration.heartbeatIntervalMs, 500)
        heartbeatTask = Task { [weak self] in
            while let self, !Task.isCancelled {
                try? await Task.sleep(nanoseconds: interval * 1_000_000)
                if Task.isCancelled { return }
                await self.sendHeartbeat()
            }
        }
    }

    private func sendHeartbeat() async {
        guard case .connected = state else { return }
        if !hasHeartbeatACK {
            await requestReconnect(reason: "heartbeat_ack_timeout")
            return
        }
        hasHeartbeatACK = false
        await logger.log(.trace, message: "Shard heartbeat", metadata: [
            "shard_id": "\(id)",
            "seq": "\(session.sequence ?? -1)"
        ])
    }

    private func handleDispatch(_ payload: GatewayPayload) async {
        guard let eventName = payload.t else { return }
        switch eventName {
        case "READY":
            if case .object(let root) = payload.d,
               case .string(let sessionID)? = root["session_id"] {
                session.sessionID = sessionID
            }
            await router?.route(ReadyEvent(sessionID: session.sessionID ?? "unknown", shardIndex: id))
        case "MESSAGE_CREATE":
            if let event = parseMessageCreate(payload.d) {
                await router?.route(event)
            } else {
                await router?.route(RawGatewayEvent(name: eventName, data: payload.d, sequence: payload.s, shardIndex: id))
            }
        default:
            await router?.route(RawGatewayEvent(name: eventName, data: payload.d, sequence: payload.s, shardIndex: id))
        }
    }

    private func parseMessageCreate(_ data: JSONValue?) -> MessageCreateEvent? {
        guard case .object(let root) = data,
              case .string(let id)? = root["id"],
              case .string(let channelID)? = root["channel_id"],
              case .string(let content)? = root["content"] else {
            return nil
        }

        let authorID: String
        if case .object(let author)? = root["author"], case .string(let value)? = author["id"] {
            authorID = value
        } else {
            authorID = "0"
        }

        let message = Message(
            id: Snowflake(rawValue: id),
            channelID: Snowflake(rawValue: channelID),
            authorID: Snowflake(rawValue: authorID),
            content: content
        )
        return MessageCreateEvent(message: message)
    }
}
