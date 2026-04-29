import Foundation
import Builders
import Interactions

public protocol CommandResponder: Sendable {
    func reply(interaction: Interaction, content: String) async throws
    func reply(interaction: Interaction, message: MessageBuilder) async throws
}

public struct CommandContext: Sendable {
    public let interaction: Interaction
    private let responder: any CommandResponder

    public init(interaction: Interaction, responder: any CommandResponder) {
        self.interaction = interaction
        self.responder = responder
    }

    public func reply(_ content: String) async throws {
        try await responder.reply(interaction: interaction, content: content)
    }

    public func reply(_ message: MessageBuilder) async throws {
        try await responder.reply(interaction: interaction, message: message)
    }
}
