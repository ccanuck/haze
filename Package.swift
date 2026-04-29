// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "ProjectSwift",
    platforms: [
        .macOS(.v13),
        .iOS(.v16)
    ],
    products: [
        .library(name: "Core", targets: ["Core"]),
        .library(name: "Gateway", targets: ["Gateway"]),
        .library(name: "REST", targets: ["REST"]),
        .library(name: "Commands", targets: ["Commands"]),
        .library(name: "Interactions", targets: ["Interactions"]),
        .library(name: "Cache", targets: ["Cache"]),
        .library(name: "Plugins", targets: ["Plugins"]),
        .library(name: "Middleware", targets: ["Middleware"]),
        .library(name: "Builders", targets: ["Builders"]),
        .library(name: "DiscordJSCompat", targets: ["DiscordJSCompat"]),
        .library(name: "Models", targets: ["Models"]),
        .library(name: "Utilities", targets: ["Utilities"]),
        .library(name: "Logging", targets: ["Logging"]),
        .library(name: "Metrics", targets: ["Metrics"]),
        .library(name: "Database", targets: ["Database"])
    ],

    dependencies: [
        .package(url: "https://github.com/ccanuck/haze", exact: "0.1.0-pre")
    ],

    targets: [
        .target(
            name: "Utilities",
            path: "Packages/Utilities/Sources/Utilities"
        ),
        .target(
            name: "Models",
            dependencies: ["Utilities"],
            path: "Packages/Models/Sources/Models"
        ),
        .target(
            name: "Logging",
            dependencies: ["Utilities"],
            path: "Packages/Logging/Sources/Logging"
        ),
        .target(
            name: "Gateway",
            dependencies: ["Models", "Utilities", "Logging"],
            path: "Packages/Gateway/Sources/Gateway"
        ),
        .target(
            name: "REST",
            dependencies: ["Models", "Utilities", "Logging"],
            path: "Packages/REST/Sources/REST"
        ),
        .target(
            name: "Middleware",
            dependencies: ["Models", "Utilities", "Logging"],
            path: "Packages/Middleware/Sources/Middleware"
        ),
        .target(
            name: "Builders",
            dependencies: ["Models", "Utilities"],
            path: "Packages/Builders/Sources/Builders"
        ),
        .target(
            name: "Interactions",
            dependencies: ["Models", "Utilities", "Builders", "Middleware", "Logging"],
            path: "Packages/Interactions/Sources/Interactions"
        ),
        .target(
            name: "Commands",
            dependencies: ["Models", "Utilities", "Interactions", "Middleware", "Logging", "Builders"],
            path: "Packages/Commands/Sources/Commands"
        ),
        .target(
            name: "Cache",
            dependencies: ["Models", "Utilities"],
            path: "Packages/Cache/Sources/Cache"
        ),
        .target(
            name: "Plugins",
            dependencies: ["Utilities", "Logging", "Models", "Commands", "Interactions", "Cache"],
            path: "Packages/Plugins/Sources/Plugins"
        ),
        .target(
            name: "Metrics",
            dependencies: ["Utilities"],
            path: "Packages/Metrics/Sources/Metrics"
        ),
        .target(
            name: "Database",
            dependencies: ["Utilities", "Logging"],
            path: "Packages/Database/Sources/Database"
        ),
        .target(
            name: "Core",
            dependencies: [
                "Gateway",
                "REST",
                "Models",
                "Utilities",
                "Logging",
                "Commands",
                "Interactions",
                "Middleware",
                "Cache",
                "Plugins",
                "Metrics",
                "Database",
                .product(name: "Haze", package: "haze")
            ],
            path: "Packages/Core/Sources/Core"
        ),
        .target(
            name: "DiscordJSCompat",
            dependencies: [
                "Core",
                "REST",
                "Gateway",
                "Commands",
                "Interactions",
                "Builders",
                "Models",
                "Logging",
                "Utilities"
            ],
            path: "Packages/DiscordJSCompat/Sources/DiscordJSCompat"
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Core", "Models"],
            path: "Packages/Core/Tests/CoreTests"
        ),
        .testTarget(
            name: "CommandsTests",
            dependencies: ["Commands"],
            path: "Packages/Commands/Tests/CommandsTests"
        )
    ]
)
