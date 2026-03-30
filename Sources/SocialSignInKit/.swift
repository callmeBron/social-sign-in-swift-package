//
//  SocialSignInKit 2.swift
//  SocialSignInKit
//
//  Created by Bronwyn dos Santos on 2026/03/30.
//


public enum SocialSignInKit {
    public static func configure(googleClientID: String) {
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: googleClientID)
    }

    public static func handle(_ url: URL) {
        GIDSignIn.sharedInstance.handle(url)
    }
}