// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "social_share",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        // The library name uses dashes where the target/package name uses underscores.
        .library(name: "social-share", targets: ["social_share"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
        // Mirrors the FBSDKCoreKit / FBSDKShareKit "18.0" CocoaPods dependency.
        // FacebookShare transitively links FBSDKShareKit (and FBSDKCoreKit), which
        // the Objective-C source imports via <FBSDKShareKit/FBSDKShareKit.h>.
        .package(url: "https://github.com/facebook/facebook-ios-sdk.git", from: "18.0.0")
    ],
    targets: [
        .target(
            name: "social_share",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "FacebookShare", package: "facebook-ios-sdk")
            ],
            cSettings: [
                // Let the implementation file resolve its own public header
                // (`#import "SocialSharePlugin.h"`) from include/social_share/.
                .headerSearchPath("include/social_share")
            ]
        )
    ]
)
