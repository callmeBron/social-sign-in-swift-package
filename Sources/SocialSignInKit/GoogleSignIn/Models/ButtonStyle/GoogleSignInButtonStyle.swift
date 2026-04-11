import SwiftUI

public enum GoogleSignInButtonStyle {
    case standard(colorScheme: GoogleSignInButtonColorScheme = .light)
    case icon(colorScheme: GoogleSignInButtonColorScheme = .light)
    case wide(colorScheme: GoogleSignInButtonColorScheme = .light)
}

public enum GoogleSignInButtonColorScheme {
    case light
    case dark
}
