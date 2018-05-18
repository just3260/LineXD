// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "LineXD",
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "2.4.0"),
        .package(url: "https://github.com/happiness9721/line-bot-sdk-swift.git", .upToNextMajor(from: "2.0.0"))
    ],
    targets: [
        .target(name: "run", dependencies: ["Vapor", "LineBot"]),
    ]
)

