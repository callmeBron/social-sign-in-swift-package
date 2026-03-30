import Foundation

public enum SocialSignInError: Error, LocalizedError, @unchecked Sendable {
    case cancelled
    case missingClientID
    case missingToken
    case userMappingFailed
    case underlying(Error)

    public var errorDescription: String? {
        switch self {
        case .cancelled:            return "Sign-in was cancelled."
        case .missingClientID:      return "Google client ID is not configured."
        case .missingToken:         return "Authentication tokens were not returned."
        case .userMappingFailed:    return "Failed to build user from Google response."
        case .underlying(let err):  return err.localizedDescription
        }
    }
}
