import Foundation
import FirebaseAuth
import GoogleSignIn

class AuthViewModel: ObservableObject {
    @Published var user: User?

    private var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?

    init() {
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { auth, user in
            self.user = user
        }
    }

    deinit {
        if let handle = authStateDidChangeListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }

        GIDSignIn.sharedInstance.signIn(with: config, presenting: rootViewController) { user, error in
            if let error = error {
                print("Error signing in with Google: \(error)")
                return
            }

            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken else {
                print("Google authentication or ID token missing.")
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase sign in error: \(error)")
                    return
                }

                // User is signed in
                print("User signed in with Google: \(authResult?.user.uid ?? "")")
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
        } catch {
            print("Error signing out: \(error)")
        }
    }
}

