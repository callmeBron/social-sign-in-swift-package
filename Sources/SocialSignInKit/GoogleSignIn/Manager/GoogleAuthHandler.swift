import GoogleSignIn

enum GoogleAuthHandler {
    
    static func signIn(clientID: String, presentingViewController: UIViewController) async -> Result<SocialUser, SocialSignInError> {
        await withCheckedContinuation { continuation in
            GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
                if let error {
                    let nsError = error as NSError
                    // GIDSignIn error code 1 = user cancelled
                    if nsError.code == GIDSignInError.canceled.rawValue {
                        continuation.resume(returning: .failure(.cancelled))
                    } else {
                        continuation.resume(returning: .failure(.underlying(error)))
                    }
                    return
                }
                
                guard let googleUser = result?.user else {
                    continuation.resume(returning: .failure(.userMappingFailed))
                    return
                }
                
                let rawUser = GoogleAuthHandler.extractRawUser(from: googleUser)
                let mappedResult = UserMapper.map(from: rawUser)
                continuation.resume(returning: mappedResult)
            }
        }
    }
    
    private static func extractRawUser(from googleUser: GIDGoogleUser) -> RawGoogleUser {
        RawGoogleUser(
            id: googleUser.userID ?? UUID().uuidString,
            email: googleUser.profile?.email ?? "",
            displayName: googleUser.profile?.name,
            givenName: googleUser.profile?.givenName,
            familyName: googleUser.profile?.familyName,
            profileImageURL: googleUser.profile?.imageURL(withDimension: 200),
            idToken: googleUser.idToken?.tokenString,
            accessToken: googleUser.accessToken.tokenString
        )
    }
}
