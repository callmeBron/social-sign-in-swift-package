import GoogleSignIn

enum UserMapper {
    static func map(from raw: RawGoogleUser) -> Result<SocialUser, SocialSignInError> {
        guard let idToken = raw.idToken, !idToken.isEmpty else {
            return .failure(.missingToken)
        }
        
        return .success(
            SocialUser(id: raw.id,
                       email: raw.email,
                       displayName: raw.displayName,
                       givenName: raw.givenName,
                       familyName: raw.familyName,
                       profileImageURL: raw.profileImageURL,
                       idToken: idToken,
                       accessToken: raw.accessToken)
        )
    }
}
