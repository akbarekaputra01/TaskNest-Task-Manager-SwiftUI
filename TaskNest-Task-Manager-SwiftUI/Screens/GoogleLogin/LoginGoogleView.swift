import SwiftUI
import Firebase
import GoogleSignIn

struct GoogleLoginView: View {

    @State private var user: GIDGoogleUser?

    var body: some View {
        VStack {
            if let user = user {
                Text("Hello, \(user.profile?.name ?? "Unknown")!")
            } else {
                GoogleSignInButton()
                    .frame(width: 200, height: 50)
                    .onTapGesture {
                        signInWithGoogle()
                    }
            }
        }
        .onAppear {
            GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                if let user = user {
                    self.user = user
                } else if let error = error {
                    print("Error restoring previous sign-in: \(error.localizedDescription)")
                }
            }
        }
    }

    private func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("Error: FirebaseApp not configured correctly")
            return
        }

        let config = GIDConfiguration(clientID: clientID)
        
        guard let presentingViewController = UIApplication.shared.windows.first?.rootViewController else {
            print("Error: No root view controller available")
            return
        }

        GIDSignIn.sharedInstance.signIn(with: config, presenting: presentingViewController) { user, error in
            if let error = error {
                print("Error signing in with Google: \(error.localizedDescription)")
                return
            }

            guard let authentication = user?.authentication, let idToken = authentication.idToken else {
                print("Error: Missing authentication object or ID token")
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)

            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print("Error authenticating with Firebase: \(error.localizedDescription)")
                    return
                }

                self.user = user
            }
        }
    }
}

struct GoogleLoginView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleLoginView()
    }
}
