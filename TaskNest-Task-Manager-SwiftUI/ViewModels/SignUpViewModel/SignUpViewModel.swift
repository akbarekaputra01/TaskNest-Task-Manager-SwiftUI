//
//  SignUpViewModel.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 15/06/24.
//

import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseStorage
import GoogleSignIn
import SwiftUI

final class SignUpViewModel: ObservableObject {
    @AppStorage("user") private var userData: Data?

    @Published var user = User()
    @Published var alertItem: AlertItem?

    @Published var confirmPassword = ""
    @Published var isAgree = false

    @Published var signUpImage: UIImage?
    @Published var showingImagePicker = false

    @Published var isLoading = false

    @Published var isSignInButtonEnabled = true

    private var db = Firestore.firestore()

    var isValidRegisterForm: Bool {
        guard
            !user.name.isEmpty && !user.username.isEmpty && !user.email.isEmpty && !user.password.isEmpty
            && !confirmPassword.isEmpty
        else {
            alertItem = AlertContext.invalidForm
            return false
        }

        guard user.email.isValidEmail else {
            alertItem = AlertContext.invalidEmail
            return false
        }

        guard user.password == confirmPassword else {
            alertItem = AlertContext.invalidRegistPassword
            return false
        }

        guard isAgree else {
            alertItem = AlertContext.invalidAgreement
            return false
        }

        return true
    }

    func signUp() {
        guard isValidRegisterForm else { return }
        isLoading = true
        createUserAuth()
    }

    private func createUserAuth() {
        Auth.auth().createUser(withEmail: user.email, password: user.password) {
            // [weak self] is used in handling asynchronous closures to prevent strong reference cycles (or so-called retain cycles). This is an important pattern to prevent memory leaks in applications.
            [weak self] authResult, error in
            guard let self = self else { return }

            if let error = error {
                self.isLoading = false
                alertItem = AlertItem(
                    title: Text("Error createUserAuth"),
                    message: Text(error.localizedDescription),
                    dismissButton: .default(Text("OK")))
                print("Error createUserAuth: \(error.localizedDescription)")
            } else if let authResult = authResult {
                self.user.id = authResult.user.uid
                self.user.createdAt = Date()

                self.uploadImageToStorage()
            }
        }
    }

    private func uploadImageToStorage() {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let imageRef = storageReference.child("profilePictures").child(user.id)

        if let imageData = signUpImage?.jpegData(compressionQuality: 0.5) {
            imageRef.putData(imageData, metadata: nil) { [weak self] _, error in
                guard let self = self else { return }

                if let error = error {
                    self.isLoading = false
                    alertItem = AlertItem(
                        title: Text("Error uploadImageToStorage"),
                        message: Text(error.localizedDescription),
                        dismissButton: .default(Text("OK")))
                    print("Error uploadImageToStorage: \(error.localizedDescription)")
                } else {
                    self.getImageUrl(imageRef)
                    print("Done uploadImageToStorage")
                }
            }
        } else {
            print("No image found")
            uploadUserDataToDB()
        }
    }

    private func getImageUrl(_ imageRef: StorageReference) {
        imageRef.downloadURL { [weak self] url, error in
            guard let self = self else { return }

            if let url = url {
                self.user.imageUrl = url.absoluteString
                if !self.user.imageUrl.isEmpty {
                    print("Done getImageUrl: \(self.user.imageUrl)")
                    self.uploadUserDataToDB()
                }
            } else if let error = error {
                self.isLoading = false
                alertItem = AlertItem(
                    title: Text("Error getImageUrl"),
                    message: Text(error.localizedDescription),
                    dismissButton: .default(Text("OK")))
                print("Error getImageUrl: \(error.localizedDescription)")
            }
        }
    }

    private func uploadUserDataToDB() {
        do {
            let userCollection = db.collection("users")
            try userCollection.document(user.id).setData(from: user)

            isLoading = false
            alertItem = AlertContext.userRegistSuccess
            print("Done uploadUserDataToDB")
        } catch {
            isLoading = false
            alertItem = AlertItem(
                title: Text("Error uploadUserDataToDB"),
                message: Text(error.localizedDescription),
                dismissButton: .default(Text("OK")))
            print("Error uploadUserDataToDB: \(error.localizedDescription)")
        }
    }

    func signInWithGoogle(
        withPresenting: UIViewController,
        completion: @escaping (Error?) -> Void
    ) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("Failed to get clientID")
            completion(
                NSError(
                    domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get clientID"])
            )
            return
        }

        print("ClientID: \(clientID)")

        // Membuat objek konfigurasi Google Sign In.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        print("Successfully configured")

        // Memulai alur sign in!
        GIDSignIn.sharedInstance.signIn(withPresenting: withPresenting) { result, error in
            if let error = error {
                print("SignIn error: \(error.localizedDescription)")
                completion(error)
                return
            }

            print("Login successfully")

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                print("Failed to get user or idToken.")
                completion(
                    NSError(
                        domain: "", code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Failed to get user or idToken."]))
                return
            }

            print("idToken: \(idToken)")

            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString)

            print("Credential: \(credential)")

            // Opsional, Anda dapat menambahkan kode untuk sign in dengan Firebase menggunakan credential
            // Auth.auth().signIn(with: credential) { authResult, error in
            //     if let error = error {
            //         print("Firebase signIn error: \(error.localizedDescription)")
            //         completion(error)
            //         return
            //     }
            //     print("Firebase signIn berhasil")
            //     completion(nil)
            // }

            // Jika sign-in Google berhasil
            completion(nil)
        }
    }
}
