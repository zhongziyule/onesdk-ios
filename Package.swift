// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "oneSDK",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "oneSDK",
            targets: ["oneSDK"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/facebook/facebook-ios-sdk.git",
            from: "18.0.0"),
        .package(
            url: "https://github.com/google/GoogleSignIn-iOS.git",
            from: "8.0.0"),
        .package(
            url: "https://github.com/adjust/ios_sdk.git",
            from: "5.4.0")
    ],
    targets: [
        .binaryTarget(
            name: "oneSDKBranch",
            url: "https://github.com/zhongziyule/oneSDK-ios/raw/main/oneSDK.xcframework.zip",
            checksum: "6ce0cf7557f5c2c798bc3dbd311b1f50a86154a1d475a3a516a4d657eadbd3d0"
        ),
        .target(
            name: "oneSDK",
            dependencies: [
                "oneSDKBranch",
                .product(name: "FacebookAEM", package: "facebook-ios-sdk"),
                .product(name: "FacebookBasics", package: "facebook-ios-sdk"),
                .product(name: "FacebookCore", package: "facebook-ios-sdk"),
                .product(name: "FacebookLogin", package: "facebook-ios-sdk"),
                .product(name: "FacebookShare", package: "facebook-ios-sdk"),
                .product(name: "FacebookGamingServices", package: "facebook-ios-sdk"),
                .product(name: "AdjustGoogleOdm", package: "ios_sdk"),
                .product(name: "AdjustSdk", package: "ios_sdk"),
                .product(name: "AdjustWebBridge", package: "ios_sdk"),
                .product(name: "GoogleSignIn", package: "GoogleSignIn-iOS"),
                .product(name: "GoogleSignInSwift", package: "GoogleSignIn-iOS")
            ],
        ),
        .testTarget(
            name: "oneSDKTests",
            dependencies: ["oneSDK"]
        ),
    ]
)
