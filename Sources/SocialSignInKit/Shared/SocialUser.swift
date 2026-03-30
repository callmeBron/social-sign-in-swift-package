//
//  SocialUser.swift
//  SocialSignInKit
//
//  Created by Bronwyn dos Santos on 2026/03/30.
//


import Foundation

public struct SocialUser {
    public let id: String
    public let email: String
    public let displayName: String?
    public let givenName: String?
    public let familyName: String?
    public let profileImageURL: URL?
    public let idToken: String
    public let accessToken: String
}