import SwiftUI
import AuthenticationServices

struct AppleSignInButtonRepresentable: UIViewRepresentable {
    let style: AppleSignInButtonStyle
    let onResult: @MainActor (Result<SocialUser, SocialSignInError>) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(onResult: onResult)
    }

    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        let button = ASAuthorizationAppleIDButton(
            authorizationButtonType: .signIn,
            authorizationButtonStyle: style.colorScheme
        )
        button.addTarget(
            context.coordinator,
            action: #selector(Coordinator.didTapSignIn),
            for: .touchUpInside
        )
        return button
    }

    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}
}

extension AppleSignInButtonRepresentable {
    @MainActor
    final class Coordinator: NSObject {
        private let onResult: @MainActor (Result<SocialUser, SocialSignInError>) -> Void

        init(onResult: @escaping @MainActor (Result<SocialUser, SocialSignInError>) -> Void) {
            self.onResult = onResult
        }

        @objc func didTapSignIn() {
            Task {
                let result = await AppleSignInManager.shared.signIn()
                onResult(result)
            }
        }
    }
}
