import AuthenticationServices

enum AppleAuthHandler {
    static func signIn() async -> Result<RawAppleUser, SocialSignInError> {
        await withCheckedContinuation { continuation in
            let provider = ASAuthorizationAppleIDProvider()
            let request = provider.createRequest()
            request.requestedScopes = [.fullName, .email]

            let controller = ASAuthorizationController(authorizationRequests: [request])

            let delegate = AppleSignInDelegate { result in
                continuation.resume(returning: result)
            }

            objc_setAssociatedObject(
                controller,
                "delegate",
                delegate,
                .OBJC_ASSOCIATION_RETAIN
            )

            controller.delegate = delegate
            controller.presentationContextProvider = delegate
            controller.performRequests()
        }
    }
}
