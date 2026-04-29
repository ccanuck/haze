import XCTest
@testable import Core
import Models

final class DiscordClientTests: XCTestCase {
    func testEventBusDispatchesTypedEvent() async throws {
        let bus = EventBus()
        let expectation = expectation(description: "MessageCreateEvent received")

        await bus.on(MessageCreateEvent.self) { event in
            XCTAssertEqual(event.message.content, "hello")
            expectation.fulfill()
        }

        let event = MessageCreateEvent(
            message: Message(id: "1", channelID: "2", authorID: "3", content: "hello")
        )
        try await bus.emit(event)

        await fulfillment(of: [expectation], timeout: 1.0)
    }
}
