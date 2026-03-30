import SwiftUI
import SocialSignInKit

@main
struct SignInPackagesTestApplicationApp: App {
    
    init() {
        SocialSignInKit.configure(googleClientID: "408804780942-jhb53hlo69pd8a698ds86b4bkijjh7ah.apps.googleusercontent.com")
    }
    
    var body: some Scene {
        WindowGroup {
            LogInView()
                .onOpenURL { url in
                    SocialSignInKit.handle(url)
                }
        }
    }
}
