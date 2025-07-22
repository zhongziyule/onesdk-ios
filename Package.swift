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
            checksum: "2defa46bcac3e4c4dd710e8a81a70a96006913cf7e37340b8c105da797840862"
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
            linkerSettings: [
                // 链接 Adjust 核心框架
                .linkedFramework("Adjust"),
                // 链接 Adjust 签名框架（解决 ODCConversionManager 问题）
                .linkedFramework("AdjustSigSdk"),
                // 确保 Objective-C 类被正确加载
                .unsafeFlags(["-ObjC"])
            ]
        ),
        .testTarget(
            name: "oneSDKTests",
            dependencies: ["oneSDK"]
        ),
    ]
)
