import AuthenticationServices

final class AppleSignInDelegate: NSObject {
    private let onResult: (Result<RawAppleUser, SocialSignInError>) -> Void
    
    init(onResult: @escaping (Result<RawAppleUser, SocialSignInError>) -> Void) {
        self.onResult = onResult
    }
}

extension AppleSignInDelegate: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            onResult(.failure(.userMappingFailed))
            return
        }
        
        guard
            let identityTokenData = credential.identityToken,
            let identityToken = String(data: identityTokenData, encoding: .utf8),
            let authCodeData = credential.authorizationCode,
            let authorizationCode = String(data: authCodeData, encoding: .utf8)
        else {
            onResult(.failure(.missingToken))
            return
        }
        
        let rawUser = RawAppleUser(id: credential.user,
                                   email: credential.email,
                                   givenName: credential.fullName?.givenName,
                                   familyName: credential.fullName?.familyName,
                                   identityToken: identityToken,
                                   authorizationCode: authorizationCode)
        
        onResult(.success(rawUser))
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let asError = error as? ASAuthorizationError
        if asError?.code == .canceled {
            onResult(.failure(.cancelled))
        } else {
            onResult(.failure(.underlying(error)))
        }
    }
}

extension AppleSignInDelegate:  ASAuthorizationControllerPresentationContextProviding  {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first(where: { $0.activationState == .foregroundActive })?
            .windows
            .first(where: { $0.isKeyWindow }) ?? ASPresentationAnchor()
    }
}
