//
//  SignupViewModel.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 15/06/24.
//

import Firebase
import SwiftUI

final class SignupViewModel: ObservableObject {
  @AppStorage("user") private var userData: Data?

  @Published var user = User()
  @Published var alertItem: AlertItem?

  @Published var confirmPassword = ""
  @Published var isAgree = false

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

    do {
      let data = try JSONEncoder().encode(user)
      userData = data

      Auth.auth().createUser(withEmail: user.email, password: user.password) { authResult, error in
        if let error = error {
          print("Error registering user: \(error.localizedDescription)")
          // Custom alert
          self.alertItem = AlertItem(
            title: Text("Error registering user"),
            message: Text(error.localizedDescription),
            dismissButton: .default(Text("OK")))
        } else {
          print("User registered successfully.")
          self.alertItem = AlertContext.userRegistSuccess
        }
      }
    } catch {
      alertItem = AlertContext.invalidUserData
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
