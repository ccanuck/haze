import Foundation
import Interactions

public typealias CommandCheck = @Sendable (Interaction) async throws -> Void

public enum BuiltinChecks {
    public static func guildOnly() -> CommandCheck {
        { interaction in
            guard interaction.guildID != nil else {
                throw CommandError.checkFailed(reason: "This command can only be used in a guild.")
            }
        }
    }
}
