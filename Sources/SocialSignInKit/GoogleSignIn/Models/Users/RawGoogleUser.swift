import Foundation

struct RawGoogleUser: Sendable {
    let id: String
    let email: String
    let displayName: String?
    let givenName: String?
    let familyName: String?
    let profileImageURL: URL?
    let idToken: String?
    let accessToken: String
}
