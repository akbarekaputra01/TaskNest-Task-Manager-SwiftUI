//
//  SignUpView.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 15/06/24.
//

import Firebase
import SwiftUI

struct SigupView: View {
  // to close this screen
  @Environment(\.presentationMode) var presentationMode

  @StateObject var viewModel = SignupViewModel()

  var body: some View {
    NavigationView {
      VStack(alignment: .leading, spacing: 22) {
        Spacer()

        HStack {
          Spacer()
          Text("Sign Up")
            .font(.largeTitle)
            .bold()
          Spacer()
        }

        TextField("Email", text: $viewModel.email)
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(10)
          .autocapitalization(.none)
          .disableAutocorrection(true)

        SecureField("Password", text: $viewModel.password)
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(10)
          .autocapitalization(.none)
          .disableAutocorrection(true)

        SecureField("Password", text: $viewModel.confirmPassword)
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(10)
          .autocapitalization(.none)
          .disableAutocorrection(true)

        HStack {
          Button {
            viewModel.isAgree.toggle()
          } label: {
            Image(systemName: viewModel.isAgree ? "checkmark.circle.fill" : "circle")
          }
          Text("Agree with Terms & Conditions")
          Spacer()
        }

        Button(action: {
          viewModel.register()
        }) {
          Text("Sign up")
            .frame(maxWidth: .infinity)
            .fontWeight(.bold)
        }
        .padding()
        .disabled(
          viewModel.email.isEmpty || viewModel.password.isEmpty || viewModel.confirmPassword.isEmpty
        )
        .background(Color.accentColor)
        .foregroundColor(.white)
        .cornerRadius(10)
        .opacity(
          viewModel.email.isEmpty
            ? 0.5
            : viewModel.password.isEmpty
              ? 0.5
              : viewModel.confirmPassword.isEmpty
                ? 0.5 : !viewModel.isAgree ? 0.5 : 1)

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
          NavigationLink(destination: AccountView().navigationBarBackButtonHidden()) {
            Text("Sign In")
              .fontWeight(.bold)
          }
          Spacer()
        }

        Spacer()
      }

      .padding()
    }

  }
}

#Preview{
  SigupView()
}
