import SwiftUI
import AuthenticationServices

public struct AppleSignInButton: View {
    private let style: AppleSignInButtonStyle
    private let onResult: (Result<SocialUser, SocialSignInError>) -> Void

    public init(style: AppleSignInButtonStyle = .dark, onResult: @escaping (Result<SocialUser, SocialSignInError>) -> Void) {
        self.style = style
        self.onResult = onResult
    }

    public var body: some View {
        AppleSignInButtonRepresentable(style: style, onResult: onResult)
            .frame(height: 50)
    }
}
