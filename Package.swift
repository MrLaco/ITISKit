// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "ITISKit",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(name: "ITISKit", targets: ["ITISKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/robb/Cartography", from: "4.0.0"),
        .package(url: "https://github.com/imodeveloperlab/ActiveLabel.swift", from: "1.1.7"),
        .package(url: "https://github.com/onevcat/Kingfisher", from: "7.10.1"),
        .package(url: "https://github.com/vadymmarkov/Fakery", from: "5.1.0"),
        .package(url: "https://github.com/airbnb/HorizonCalendar.git", from: "1.13.3"),
    ],
    targets: [
        .target(
            name: "ITISKit",
            dependencies: ["Cartography", "Kingfisher", .product(name: "ActiveLabel", package: "ActiveLabel.swift")],
            path: "Sources/ITISKit",
            resources: [
                .process("Appearance/Fonts/Noteworthy.plist"),
                .process("Appearance/Fonts/HoeflerText.plist")
            ]
        ),
    ]
)
