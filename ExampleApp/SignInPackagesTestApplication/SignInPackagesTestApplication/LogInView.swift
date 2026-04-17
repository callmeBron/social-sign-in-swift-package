import SwiftUI
import SocialSignInKit

enum AuthState {
    case idle
    case loading
    case signedIn(SocialUser)
    case error(SocialSignInError)
}

struct LogInView: View {
    @State private var authState: AuthState = .idle
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                switch authState {
                case .idle:
                    idleView
                case .loading:
                    ProgressView("Signing in...")
                case .signedIn(let result):
                    signedInView(result)
                case .error(let message):
                    errorView(message)
                }
            }
            .padding()
            .navigationTitle("SocialSignInKit")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    @ViewBuilder
    var idleView: some View {
        VStack(spacing: 20) {
            Image("socialimage")
                .resizable()
                .frame(width: 200, height: 200)
            Spacer()
            
            Divider()
            Text("Social Sign in")
                .font(.headline)
                .bold()
            
            GoogleSignInButton(style: .standard(colorScheme: .dark)) { result in
                switch result {
                case .success(let user):
                    authState = .signedIn(user)
                case .failure(let error):
                    authState = .error(error)
                }
            }
            
            GoogleSignInButton(style: .standard(colorScheme: .light)) { result in
                switch result {
                case .success(let user):
                    authState = .signedIn(user)
                case .failure(let error):
                    authState = .error(error)
                }
            }
            
            AppleSignInButton(style: .dark) { result in
                switch result {
                case .success(let user):
                    print("Signed in as \(user.displayName ?? user.email)")
                case .failure(let error):
                    if case .cancelled = error { return }
                    print(error.localizedDescription)
                }
            }
            
            AppleSignInButton(style: .light) { result in
                switch result {
                case .success(let user):
                    print("Signed in as \(user.displayName ?? user.email)")
                case .failure(let error):
                    if case .cancelled = error { return }
                    print(error.localizedDescription)
                }
            }
            
            AppleSignInButton(style: .lightOutline) { result in
                switch result {
                case .success(let user):
                    print("Signed in as \(user.displayName ?? user.email)")
                case .failure(let error):
                    if case .cancelled = error { return }
                    print(error.localizedDescription)
                }
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    func signedInView(_ result: SocialUser) -> some View {
        VStack(spacing: 20) {
            Text("Signed in")
                .font(.headline)
            
            AsyncImage(url: result.profileImageURL)
                .clipShape(.circle)
                .frame(width: 50)
            
            
            LabeledContent("Name", value: result.displayName ?? "no name found")
            LabeledContent("Email", value: result.email)
            Divider()
            Spacer()
            Button("Sign out", role: .destructive) {
                authState = .idle
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    @ViewBuilder
    private func errorView(_ message: SocialSignInError) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundStyle(.red)
            Text(message.localizedDescription ?? "no failure reason found")
                .multilineTextAlignment(.center)
            Button("Try again") { authState = .idle }
        }
    }
}
