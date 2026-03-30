import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignInButtonRepresentable: UIViewRepresentable {
    let style: GoogleSignInButtonStyle
    let onResult: @MainActor (Result<SocialUser, SocialSignInError>) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(onResult: onResult)
    }

    func makeUIView(context: Context) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.style = style.gidStyle
        button.colorScheme = .light
        button.addTarget(
            context.coordinator,
            action: #selector(Coordinator.didTapSignIn),
            for: .touchUpInside
        )
        return button
    }

    func updateUIView(_ uiView: GIDSignInButton, context: Context) {
        uiView.style = style.gidStyle
        uiView.colorScheme = style.gidColorScheme
    }
}

// MARK: - Coordinator
extension GoogleSignInButtonRepresentable {
    @MainActor final class Coordinator: NSObject {
        private let onResult: @MainActor (Result<SocialUser, SocialSignInError>) -> Void

        init(onResult: @escaping @MainActor (Result<SocialUser, SocialSignInError>) -> Void) {
            self.onResult = onResult
        }

        @objc func didTapSignIn() {
            Task { @MainActor in
                let result = await GoogleSignInManager.shared.signIn()
                onResult(result)
            }
        }
    }
}

// MARK: - Style mapping
private extension GoogleSignInButtonStyle {
    var gidStyle: GIDSignInButtonStyle {
        switch self {
        case .standard: return .standard
        case .icon:     return .iconOnly
        case .wide:     return .wide
        }
    }

    var gidColorScheme: GIDSignInButtonColorScheme {
        switch self {
        case .standard(let colorScheme),
             .icon(let colorScheme),
             .wide(let colorScheme):
            return colorScheme == .dark ? .dark : .light
        }
    }
}
