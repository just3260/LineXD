// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "LineXD",
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "2.4.0"),
        .package(url: "https://github.com/IBM-Swift/BlueCryptor.git", from: "1.0.0")
    ],
    targets: [
        .target(name: "run", dependencies: ["Vapor", "Cryptor"]),
    ]
)

