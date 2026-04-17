import AuthenticationServices

public enum AppleSignInButtonStyle {
    case dark
    case light
    case lightOutline
    
    var colorScheme: ASAuthorizationAppleIDButton.Style {
        switch self {
        case .dark:
            return .black
        case .light:
            return .white
        case .lightOutline:
            return .whiteOutline
        }
    }
}
