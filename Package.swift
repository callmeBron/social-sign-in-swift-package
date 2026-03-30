// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SocialSignInKit",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(name: "SocialSignInKit", targets: ["SocialSignInKit"]),
    ],
    dependencies: [
        /// Non-negotiable: Apple
        /// 'App Store Review Guideline 4.8 states that if your app offers third-party social sign-in, Sign in with Apple must also be offered.'
        
        /// Expected by most users: Google, Facebook,
        /// Situational: Microsoft, Twitter/X, GitHub
        /// Niche: TikTok, LinkedIn, Discord
        
        .package(url: "https://github.com/google/GoogleSignIn-iOS",
                 from: "9.0.0")
    ],
    targets: [
        .target(
            name: "SocialSignInKit",
            dependencies: [
                .product(name: "GoogleSignIn", package: "GoogleSignIn-iOS"),
                .product(name: "GoogleSignInSwift", package: "GoogleSignIn-iOS"),
            ]
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
