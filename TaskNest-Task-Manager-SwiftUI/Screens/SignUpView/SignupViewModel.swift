//
//  SignupViewModel.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 15/06/24.
//

import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseStorage
import SwiftUI

final class SignupViewModel: ObservableObject {
  @AppStorage("user") private var userData: Data?

  @Published var user = User()
  @Published var alertItem: AlertItem?

  @Published var confirmPassword = ""
  @Published var isAgree = false

  @Published var signupImage: UIImage?
  @Published var showingImagePicker = false

  @Published var isLoading = false

  private var db = Firestore.firestore()

  var isValidRegisterForm: Bool {
    guard
      !user.name.isEmpty && !user.username.isEmpty && !user.email.isEmpty && !user.password.isEmpty
        && !self.confirmPassword.isEmpty
    else {
      alertItem = AlertContext.invalidForm
      return false
    }

    guard user.email.isValidEmail else {
      alertItem = AlertContext.invalidEmail
      return false
    }

    guard user.password == self.confirmPassword else {
      alertItem = AlertContext.invalidRegistPassword
      return false
    }

    guard self.isAgree else {
      alertItem = AlertContext.invalidAgreement
      return false
    }

    return true
  }

  func signup() {
    guard isValidRegisterForm else { return }
    self.isLoading = true
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
    let imageRef = storageReference.child("profilePictures").child(self.user.id)

    if let imageData = self.signupImage?.jpegData(compressionQuality: 0.5) {
      imageRef.putData(imageData, metadata: nil) { [weak self] metadata, error in
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
      self.uploadUserDataToDB()
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
      let userCollection = self.db.collection("users")
      try userCollection.document(self.user.id).setData(from: self.user)

      self.isLoading = false
      alertItem = AlertContext.userRegistSuccess
      print("Done uploadUserDataToDB")
    } catch let error {
      self.isLoading = false
      alertItem = AlertItem(
        title: Text("Error uploadUserDataToDB"),
        message: Text(error.localizedDescription),
        dismissButton: .default(Text("OK")))
      print("Error uploadUserDataToDB: \(error.localizedDescription)")
    }
  }

  func signOut() {
    do {
      try Auth.auth().signOut()
    } catch {
      print("Error signing out: \(error.localizedDescription)")
    }
  }
}
