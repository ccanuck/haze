import XCTest
@testable import Commands
import Builders
import Interactions

private actor TestResponder: CommandResponder {
    private(set) var replies: [String] = []

    func reply(interaction: Interaction, content: String) async throws {
        replies.append(content)
    }

    func reply(interaction: Interaction, message: MessageBuilder) async throws {
        replies.append(message.content ?? "")
    }

    func snapshot() -> [String] { replies }
}

private struct PingCommand: Command {
    static let name = "ping"
    static let description = "Ping command"

    func execute(context: CommandContext) async throws {
        try await context.reply("Pong!")
    }
}

final class CommandRegistryTests: XCTestCase {
    func testExecutesRegisteredCommand() async throws {
        let responder = TestResponder()
        let registry = CommandRegistry(responder: responder)
        await registry.register(PingCommand())

        let interaction = Interaction(
            id: "1",
            type: .applicationCommand,
            name: "ping",
            token: "token"
        )
        try await registry.execute(interaction: interaction)
        let messages = await responder.snapshot()
        XCTAssertEqual(messages, ["Pong!"])
    }
}
