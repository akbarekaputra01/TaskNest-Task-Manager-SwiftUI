//
//  SignUpView.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 15/06/24.
//

import Firebase
import SwiftUI

struct SignUpView: View {
  // to close this screen
  @Environment(\.presentationMode) var presentationMode

  @State private var email = ""
  @State private var password = ""
  @State private var confirmPassword = ""
  @State private var isAgree = false
  @State private var isLoggedIn: Bool = false
  @State private var isCompleted = false

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
        isLoggedIn = true
        presentationMode.wrappedValue.dismiss()
      }
    }
  }

  func signOut() {
    do {
      try Auth.auth().signOut()
      isLoggedIn = false
    } catch {
      print("Error signing out: \(error.localizedDescription)")
    }
  }

  var body: some View {
    NavigationView {
      VStack(alignment: .leading, spacing: 22) {
        Spacer()
        Text("Create Account")
          .font(.largeTitle)
          .bold()

        TextField("Email", text: $email)
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(10)
          .autocapitalization(.none)
          .disableAutocorrection(true)

        SecureField("Password", text: $password)
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(10)
          .autocapitalization(.none)
          .disableAutocorrection(true)

        SecureField("Password", text: $confirmPassword)
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(10)
          .autocapitalization(.none)
          .disableAutocorrection(true)

        HStack {
          Button {
            isAgree.toggle()
          } label: {
            Image(systemName: isAgree ? "checkmark.circle.fill" : "circle")
          }
          Text("Agree with Terms & Conditions")
          Spacer()
        }

        Button(action: {
          register()
        }) {
          Text("Sign up")
            .fontWeight(.bold)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .disabled(email.isEmpty || password.isEmpty || confirmPassword.isEmpty)
        .background(Color.accentColor)
        .foregroundColor(.white)
        .cornerRadius(10)
        .opacity(
          email.isEmpty
            ? 0.8 : password.isEmpty ? 0.8 : confirmPassword.isEmpty ? 0.8 : !isAgree ? 0.8 : 1)

        HStack {
          Rectangle()
            .fill(Color.gray.opacity(0.5))
            .frame(height: 1)
          Text("Or log in with")
            .foregroundColor(.gray.opacity(0.5))
          Rectangle()
            .fill(Color.gray.opacity(0.5))
            .frame(height: 1)
        }

        HStack {
          Spacer()
          Button {
            // Handle Apple sign in logic here
          } label: {
            Image("appleIcon")
              .frame(width: 5)
              .padding(20)
              .overlay(
                Circle()
                  .stroke(Color.gray.opacity(0.5), lineWidth: 1)
              )
          }
          Button {
            // Handle Google sign in logic here
          } label: {
            Image("googleIcon")
              .frame(width: 5)
              .padding(20)
              .overlay(
                Circle()
                  .stroke(Color.gray.opacity(0.5), lineWidth: 1)
              )
          }
          .padding(.horizontal)
          Button {
            // Handle Facebook sign in logic here
          } label: {
            Image("facebookIcon")
              .frame(width: 5)
              .padding(20)
              .overlay(
                Circle()
                  .stroke(Color.gray.opacity(0.5), lineWidth: 1)
              )
          }
          Spacer()
        }

        HStack {
          Spacer()
          Text("Already have Account?")
          NavigationLink(destination: LoginView()) {
            Text("Sign In")
          }
          Spacer()
        }

        Spacer()
      }
      .padding()
    }

  }
}

struct LoginView: View {
  var body: some View {
    Text("Login View")
  }
}

#Preview{
  SignUpView()
}
