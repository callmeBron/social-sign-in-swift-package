// The Swift Programming Language
// https://docs.swift.org/swift-book
import GoogleSignIn

public enum SocialSignInKit {
    public static func configure(googleClientID: String) {
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: googleClientID)
    }

    public static func handle(_ url: URL) {
        GIDSignIn.sharedInstance.handle(url)
    }
}
