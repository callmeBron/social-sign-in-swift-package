import SwiftUI

public struct GoogleSignInButton: View {
    private let style: GoogleSignInButtonStyle
    private let result: (Result<SocialUser, SocialSignInError>) -> Void
    
    public init(style: GoogleSignInButtonStyle,
                result: @escaping (Result<SocialUser, SocialSignInError>) -> Void) {
        self.style = style
        self.result = result
    }
    
    public var body: some View {
        GoogleSignInButtonRepresentable(style: style, onResult: result)
            .frame(height: 50)
    }
}
