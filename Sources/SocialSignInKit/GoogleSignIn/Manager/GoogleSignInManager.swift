import Foundation
import UIKit
import GoogleSignIn

@MainActor
final class GoogleSignInManager {
    @MainActor static let shared = GoogleSignInManager()
    private init() {}
    

    func signIn() async -> Result<SocialUser, SocialSignInError> {
        guard let clientID = GIDSignIn.sharedInstance.configuration?.clientID else {
            return .failure(.missingClientID)
        }
        
        guard let presentingVC = topViewController() else {
            return .failure(.underlying(NSError(domain: "GoogleSignIn",
                                                code: -1,
                                                userInfo: [NSLocalizedDescriptionKey: "No presenting view controller found."])))
        }
        
        return await GoogleAuthHandler.signIn(
            clientID: clientID,
            presentingViewController: presentingVC
        )
    }
    
    private func topViewController() -> UIViewController? {
            guard let scene = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first(where: { $0.activationState == .foregroundActive }),
                  let root = scene.windows.first(where: { $0.isKeyWindow })?.rootViewController
            else { return nil }
        
            return topMost(from: root)
    }
    
    private func topMost(from vc: UIViewController) -> UIViewController {
        if let presented = vc.presentedViewController {
            return topMost(from: presented)
        }
        if let nav = vc as? UINavigationController, let visible = nav.visibleViewController {
            return topMost(from: visible)
        }
        if let tab = vc as? UITabBarController, let selected = tab.selectedViewController {
            return topMost(from: selected)
        }
        return vc
    }
}
