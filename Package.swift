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
            checksum: "ee953627b7e9ec878f935ed6c2183efbf5b0ae1fcf1adea9844eac1c43dd43cb"
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
