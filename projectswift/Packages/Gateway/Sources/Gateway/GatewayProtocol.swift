import Foundation
import Models

public enum GatewayOpcode: Int, Sendable, Codable {
    case dispatch = 0
    case heartbeat = 1
    case identify = 2
    case presenceUpdate = 3
    case voiceStateUpdate = 4
    case resume = 6
    case reconnect = 7
    case requestGuildMembers = 8
    case invalidSession = 9
    case hello = 10
    case heartbeatACK = 11
}

public struct GatewayPayload: Sendable, Codable {
    public let op: GatewayOpcode
    public let d: JSONValue?
    public let s: Int?
    public let t: String?

    public init(op: GatewayOpcode, d: JSONValue?, s: Int? = nil, t: String? = nil) {
        self.op = op
        self.d = d
        self.s = s
        self.t = t
    }
}

public enum JSONValue: Sendable, Codable {
    case string(String)
    case number(Double)
    case bool(Bool)
    case object([String: JSONValue])
    case array([JSONValue])
    case null

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self = .null
        } else if let value = try? container.decode(Bool.self) {
            self = .bool(value)
        } else if let value = try? container.decode(Double.self) {
            self = .number(value)
        } else if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode([String: JSONValue].self) {
            self = .object(value)
        } else if let value = try? container.decode([JSONValue].self) {
            self = .array(value)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unsupported JSON payload")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let value):
            try container.encode(value)
        case .number(let value):
            try container.encode(value)
        case .bool(let value):
            try container.encode(value)
        case .object(let value):
            try container.encode(value)
        case .array(let value):
            try container.encode(value)
        case .null:
            try container.encodeNil()
        }
    }
}

public struct RawGatewayEvent: DiscordEvent {
    public let name: String
    public let data: JSONValue?
    public let sequence: Int?
    public let shardIndex: Int

    public init(name: String, data: JSONValue?, sequence: Int?, shardIndex: Int) {
        self.name = name
        self.data = data
        self.sequence = sequence
        self.shardIndex = shardIndex
    }
}
