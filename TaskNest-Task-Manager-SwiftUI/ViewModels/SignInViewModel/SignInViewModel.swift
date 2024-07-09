//
//  SignInViewModel.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 01/07/24.
//

import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import GoogleSignIn
import SwiftUI

final class SignInViewModel: ObservableObject {
    @Published var alertItem: AlertItem?
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isLoading = false
        
    @Published var user = AccountViewModel().user
    
    private let db = Firestore.firestore()
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            alertItem = AlertContext.invalidForm
            return
        }
                        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, _ in
            guard let self = self else { return }
                
            if let authResult = authResult {
                self.copyUserDataFromDBToLocal(uid: authResult.user.uid) {
                    self.alertItem = AlertContext.signInSuccess
                }
            } else {
                self.alertItem = AlertContext.invalidUserData
            }
        }
    }
        
    func signInWithGoogle(
        withPresenting viewController: UIViewController,
        closure: @escaping () -> Void
    ) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("Failed to get clientID")
            return
        }
        
        print("ClientID: \(clientID)")
            
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
            
        print("Successfully configured")
            
        // Start sign-in process!
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { result, error in
            if let error = error {
                print("Sign-in error: \(error.localizedDescription)")
                closure()
                return
            }
                
            print("Sign in successfully")
                
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                print("Failed to get user or idToken.")
                return
            }
                
            print("idToken: \(idToken)")
                
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString)
                
            print("Credential: \(credential)")
                
            // Optionally, you can add code to sign in with Firebase using the credential
            Auth.auth().signIn(with: credential) { [weak self] authResult, _ in
                guard let self = self else { return }
                    
                if let authResult = authResult {
                    self.copyUserDataFromDBToLocal(uid: authResult.user.uid) {
                        closure()
                    }
                } else {
                    self.alertItem = AlertContext.invalidUserData
                }
            }
        }
    }
    
    private func copyUserDataFromDBToLocal(uid: String, closure: @escaping () -> Void) {
        let userDocRef = db.collection("users").document(uid)
            
        userDocRef.getDocument { [weak self] (document: DocumentSnapshot?, error: Error?) in
            guard let self = self else { return }
                
            if error != nil {
                self.alertItem = AlertContext.fetchingDataError
                return
            }
                
            if let document = document, document.exists {
                let data = document.data()
                self.user.id = data?["id"] as? String ?? ""
                self.user.username = data?["username"] as? String ?? ""
                self.user.name = data?["name"] as? String ?? ""
                self.user.email = data?["email"] as? String ?? ""
                self.user.imageUrl = data?["imageUrl"] as? String ?? ""
                // Avoid storing sensitive information like password in Firestore
                self.user.password = data?["password"] as? String ?? ""
                self.user.createdAt = data?["createdAt"] as? Date ?? Date()
                AccountViewModel().updateUserData(user: self.user) {
                    closure()
                }
            } else {
                self.alertItem = AlertContext.userDocDoesntExist
            }
        }
    }
}
