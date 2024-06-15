//
//  SignupViewModel.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 15/06/24.
//

import Firebase
import SwiftUI

final class SignupViewModel: ObservableObject {
  @Published var email = ""
  @Published var password = ""
  @Published var confirmPassword = ""
  @Published var isAgree = false

  func register() {
    guard isAgree == true else {
      print("Please agree term and conditions.")
      return
    }

    // Validate password and confirm password
    guard password == confirmPassword else {
      print("Passwords do not match.")
      return
    }

    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
      if let error = error {
        print("Error registering user: \(error.localizedDescription)")
      } else {
        print("User registered successfully.")
      }
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
