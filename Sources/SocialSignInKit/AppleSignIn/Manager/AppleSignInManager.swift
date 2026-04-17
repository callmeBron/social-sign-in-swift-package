import Foundation

@MainActor
final class AppleSignInManager {
    static let shared = AppleSignInManager()
    private init() {}

    func signIn() async -> Result<SocialUser, SocialSignInError> {
        let result = await AppleAuthHandler.signIn()

        switch result {
        case .success(let rawUser):
            return AppleUserMapper.map(from: rawUser)
        case .failure(let error):
            return .failure(error)
        }
    }
}
