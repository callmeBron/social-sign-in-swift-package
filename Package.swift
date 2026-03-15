// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SocialSignInKit",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "SocialSignInKit",
            targets: ["SocialSignInKit"]
        ),
    ],
    // TODO: Add Facebook, Apple, Microsoft, GitHub, LinkedIn, TikTok, Discord
    dependencies: [
        /// Non-negotiable: Apple
        /// 'App Store Review Guideline 4.8 states that if your app offers third-party social sign-in, Sign in with Apple must also be offered.'
        
        /// Expected by most users: Google, Facebook,
        /// Situational: Microsoft, Twitter/X, GitHub
        /// Niche: TikTok, LinkedIn, Discord
    ],
    targets: [
        .target(
            name: "SocialSignInKit"
        ),
        .testTarget(
            name: "SocialSignInKitTests",
            dependencies: ["SocialSignInKit"]
        ),
        .executableTarget(
            name: "ExampleApp",
            dependencies: ["SocialSignInKit"],
            path: "ExampleApp"
        )
    ]
)
