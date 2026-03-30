import SwiftUI
import SocialSignInKit

@main
struct ExampleApp: App {

    init() { }
    
    var body: some Scene {
        WindowGroup {
            Text("Welcome User")
            
            // google sign in button examples
            GoogleSignInButton(style: .icon) { result in
                switch result {
                case .success(let user):
                    print("User details: \(user.displayName ?? "no display name found") \(user.email)")
                case .failure(let error):
                    print(error)
                }
            }
            GoogleSignInButton(style: .standard) { _ in
                print("standard button")
            }
            GoogleSignInButton(style: .wide) { _ in
                print("wide button")
            }
        }
    }
}
