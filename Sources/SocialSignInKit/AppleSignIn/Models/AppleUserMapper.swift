import Foundation

enum AppleUserMapper {
    static func map(from raw: RawAppleUser) -> Result<SocialUser, SocialSignInError> {
        /// Construct display name if available — Apple only provides this on first sign-in
        let displayName: String?
        if let given = raw.givenName, let family = raw.familyName {
            displayName = "\(given) \(family)"
        } else {
            displayName = raw.givenName ?? raw.familyName
        }

        let user = SocialUser(id: raw.id,
                              email: raw.email ?? "",
                              displayName: displayName,
                              givenName: raw.givenName,
                              familyName: raw.familyName,
                              profileImageURL: nil,
                              idToken: raw.identityToken,
                              accessToken: raw.authorizationCode)

        return .success(user)
    }
}
