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
    @Published var alertItem: AlertItem?
    @Published var user = AccountViewModel().user
    @Published var confirmPassword = ""
    @Published var isAgree = false

    @Published var signUpImage: UIImage?
    @Published var showingImagePicker = false

    @Published var isLoading = false

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

    func signUp(closure: @escaping () -> Void) {
        guard isValidRegisterForm else { return }
        isLoading = true
        createUserAuth(closure: closure)
    }

    private func createUserAuth(closure: @escaping () -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) {
            [weak self] authResult, error in
            guard let self = self else { return }

            if let error = error {
                self.isLoading = false
                alertItem = AlertContext.createUserError
                print("Error createUserAuth: \(error.localizedDescription)")
            } else if let authResult = authResult {
                self.user.id = authResult.user.uid
                self.user.createdAt = Date()
                self.uploadImageToStorage(closure: closure)
            }
        }
    }

    private func uploadImageToStorage(closure: @escaping () -> Void) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let imageRef = storageReference.child("profilePictures").child(user.id)

        if let imageData = signUpImage?.jpegData(compressionQuality: 0.5) {
            imageRef.putData(imageData, metadata: nil) { [weak self] _, error in
                guard let self = self else { return }

                if let error = error {
                    self.isLoading = false
                    self.alertItem = AlertContext.uploadImgToStorageError
                    print("Error uploadImageToStorage: \(error.localizedDescription)")
                } else {
                    self.getImageUrl(imageRef, closure: closure)
                    print("Done uploadImageToStorage")
                }
            }
        } else {
            print("No image found")
            uploadUserDataToDB(closure: closure)
        }
    }

    private func getImageUrl(_ imageRef: StorageReference, closure: @escaping () -> Void) {
        imageRef.downloadURL { [weak self] url, error in
            guard let self = self else { return }

            if let url = url {
                self.user.imageUrl = url.absoluteString
                if !self.user.imageUrl.isEmpty {
                    print("Done getImageUrl: \(self.user.imageUrl)")
                    self.uploadUserDataToDB(closure: closure)
                }
            } else if let error = error {
                self.isLoading = false
                self.alertItem = AlertItem(
                    title: Text("Error getImageUrl"),
                    message: Text(error.localizedDescription),
                    dismissButton: .default(Text("OK")))
                print("Error getImageUrl: \(error.localizedDescription)")
            }
        }
    }

    private func uploadUserDataToDB(closure: @escaping () -> Void) {
        do {
            let userCollection = db.collection("users")
            try userCollection.document(user.id).setData(from: user)

            isLoading = false
            alertItem = AlertContext.userRegistSuccess
            print("Done uploadUserDataToDB")
            closure()
        } catch {
            isLoading = false
            alertItem = AlertItem(
                title: Text("Error uploadUserDataToDB"),
                message: Text(error.localizedDescription),
                dismissButton: .default(Text("OK")))
            print("Error uploadUserDataToDB: \(error.localizedDescription)")
        }
    }
}
