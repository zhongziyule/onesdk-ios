// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "oneSDK",
    products: [
        .library(
            name: "oneSDK",
            targets: ["oneSDK"]),
    ],
    dependencies: [
        .package(url: "https://github.com/facebook/facebook-ios-sdk.git", from: "14.1.0"),
        .package(url: "https://github.com/google/GoogleSignIn-iOS.git", from: "8.0.0"),
        .package(url: "https://github.com/adjust/ios_sdk.git", from: "5.4.0")
    ],
    targets: [
        .binaryTarget(
            name: "oneSDKBranch",
            url: "https://github.com/zhongziyule/onesdk-ios/raw/main/oneSDK.xcframework.zip",
            checksum: "0ef0170c5596d1bfab4cb453f29c47a48298d27b708b211f6544b3df480b14cc"
        ),
        .target(
            name: "oneSDK",
            dependencies: [
                "oneSDKBranch",
                // Facebook 依赖
                .product(name: "FacebookAEM", package: "facebook-ios-sdk"),
                .product(name: "FacebookBasics", package: "facebook-ios-sdk"),
                .product(name: "FacebookCore", package: "facebook-ios-sdk"),
                .product(name: "FacebookLogin", package: "facebook-ios-sdk"),
                .product(name: "FacebookShare", package: "facebook-ios-sdk"),
                .product(name: "FacebookGamingServices", package: "facebook-ios-sdk"),
                // Adjust 依赖
                .product(name: "AdjustGoogleOdm", package: "ios_sdk"),
                .product(name: "AdjustSdk", package: "ios_sdk"),
                .product(name: "AdjustWebBridge", package: "ios_sdk"),
                // Google Sign-In 依赖
                .product(name: "GoogleSignIn", package: "GoogleSignIn-iOS"),
                .product(name: "GoogleSignInSwift", package: "GoogleSignIn-iOS")
            ],
            // 仅在 iOS 平台添加必要的 unsafeFlags，并限制范围
            linkerSettings: [
                .unsafeFlags(["-ObjC"], .when(platforms: [.iOS]))
            ]
        ),
        .testTarget(
            name: "oneSDKTests",
            dependencies: ["oneSDK"]
        ),
    ]
)
    