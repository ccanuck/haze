import Foundation

public enum DiscordRoutes {
    public static func gatewayBot() -> Route {
        Route(method: .get, path: "/gateway/bot")
    }

    public static func user(_ userID: String) -> Route {
        Route(method: .get, path: "/users/\(userID)")
    }

    public static func channel(_ channelID: String) -> Route {
        Route(method: .get, path: "/channels/\(channelID)")
    }

    public static func channelMessages(_ channelID: String) -> Route {
        Route(method: .post, path: "/channels/\(channelID)/messages")
    }

    public static func applicationCommands(applicationID: String) -> Route {
        Route(method: .put, path: "/applications/\(applicationID)/commands")
    }
}
