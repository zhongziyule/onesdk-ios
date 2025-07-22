// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "oneSDK",
    products: [
        .library(
            name: "oneSDK",
            targets: ["oneSDK"]),
        // 暴露Adjust相关产品，方便上层自动关联
        .library(
            name: "AdjustAutoInclude",
            targets: ["AdjustAutoInclude"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/facebook/facebook-ios-sdk.git",
            from: "14.1.0"),
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
            url: "https://github.com/zhongziyule/onesdk-ios/raw/main/oneSDK.xcframework.zip",
            checksum: "e3fd1c3cfb346aead5ced040721297eb337f181538da7f4884fd211cf904ac81"
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
            linkerSettings: [
                // 确保静态库符号和Objective-C类被完整加载
                .unsafeFlags(["-ObjC", "-all_load"])
            ]
        ),
        // 转发Adjust依赖的目标，用于自动传递到上层
        .target(
            name: "AdjustAutoInclude",
            dependencies: [
                .product(name: "AdjustSdk", package: "ios_sdk"),
                .product(name: "AdjustGoogleOdm", package: "ios_sdk"),
                .product(name: "AdjustWebBridge", package: "ios_sdk")
            ],
            linkerSettings: [
                .unsafeFlags(["-ObjC", "-all_load"])
            ]
        ),
        .testTarget(
            name: "oneSDKTests",
            dependencies: ["oneSDK"]
        ),
    ]
)