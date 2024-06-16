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

  @FocusState private var focusedTextField: FormTextField?
  enum FormTextField {
    case name, username, email, password, confirmPassword
  }

  var body: some View {
    NavigationView {
      GeometryReader { geometry in
        ScrollView {
          VStack(alignment: .leading, spacing: 22) {
            HStack {
              Text("Sign Up")
                .font(.largeTitle)
                .bold()

              Spacer()

              if let image = viewModel.signupImage {
                Image(uiImage: image)
                  .resizable()
                  .scaledToFill()
                  .frame(width: 50, height: 50)
                  .clipShape(Circle())
              } else {
                Button(action: {
                  viewModel.showingImagePicker.toggle()
                }) {
                  ZStack {
                    Image("blankPP")
                      .resizable()
                      .scaledToFit()
                      .frame(width: 50, height: 50)
                      .clipShape(Circle())
                      .opacity(0.5)

                    Image(systemName: "plus")
                      .resizable()
                      .scaledToFit()
                      .frame(width: 10)
                      .foregroundColor(.white)
                      .padding(5)
                      .background(Color.accent)
                      .clipShape(Circle())
                      .offset(x: 16, y: 16)
                  }
                }
                .sheet(isPresented: $viewModel.showingImagePicker) {
                  ImagePicker(image: $viewModel.signupImage)
                }
              }
            }

            TextField("Name", text: $viewModel.user.name)
              .padding()
              .background(Color(.systemGray6))
              .cornerRadius(10)
              .autocapitalization(.none)
              .disableAutocorrection(true)
              .focused($focusedTextField, equals: .name)
              .onSubmit { focusedTextField = .username }
              .submitLabel(.next)

            TextField("username", text: $viewModel.user.username)
              .padding()
              .background(Color(.systemGray6))
              .cornerRadius(10)
              .autocapitalization(.none)
              .disableAutocorrection(true)
              .focused($focusedTextField, equals: .username)
              .onSubmit { focusedTextField = .email }
              .submitLabel(.next)

            TextField("Email", text: $viewModel.user.email)
              .padding()
              .background(Color(.systemGray6))
              .cornerRadius(10)
              .autocapitalization(.none)
              .disableAutocorrection(true)
              .focused($focusedTextField, equals: .email)
              .onSubmit { focusedTextField = .password }
              .submitLabel(.next)

            SecureField("Password", text: $viewModel.user.password)
              .padding()
              .background(Color(.systemGray6))
              .cornerRadius(10)
              .autocapitalization(.none)
              .disableAutocorrection(true)
              .focused($focusedTextField, equals: .password)
              .onSubmit { focusedTextField = .confirmPassword }
              .submitLabel(.next)

            SecureField("Password", text: $viewModel.confirmPassword)
              .padding()
              .background(Color(.systemGray6))
              .cornerRadius(10)
              .autocapitalization(.none)
              .disableAutocorrection(true)
              .focused($focusedTextField, equals: .confirmPassword)
              .onSubmit { focusedTextField = nil }
              .submitLabel(.continue)

            HStack {
              Button {
                viewModel.isAgree.toggle()
              } label: {
                Image(systemName: viewModel.isAgree ? "checkmark.circle.fill" : "circle")
              }
              Text("Agree with Terms & Conditions")
                .font(.caption)
              Spacer()
            }

            Button(action: {
              viewModel.signup()
            }) {
              ZStack {
                if viewModel.isLoading {
                  ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                  // .scaleEffect(1.25)
                } else {
                  Text("Sign up")
                    .fontWeight(.bold)
                }
              }
              .frame(maxWidth: .infinity)
            }
            .disabled(
              viewModel.user.name.isEmpty || viewModel.user.username.isEmpty
                || viewModel.user.email.isEmpty || viewModel.user.password.isEmpty
                || viewModel.confirmPassword.isEmpty || !viewModel.isAgree
            )
            .padding()
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(10)
            .opacity(
              viewModel.user.name.isEmpty
                ? 0.5
                : viewModel.user.username.isEmpty
                  ? 0.5
                  : viewModel.user.email.isEmpty
                    ? 0.5
                    : viewModel.user.password.isEmpty
                      ? 0.5
                      : viewModel.confirmPassword.isEmpty
                        ? 0.5 : viewModel.isAgree ? 1 : 0.5
            )

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
          }
          .padding()
        }
        // To unable scroll the scrollview
        // Note: scrollView used because after enter between TextField and SecureField, screen is like bounce
        .environment(\.isScrollEnabled, false)

        // To limiting height the scrollView is just one screen
        .frame(height: geometry.size.height)
      }
    }
    .alert(item: $viewModel.alertItem) { alertItem in
      Alert(
        title: alertItem.title,
        message: alertItem.message,
        dismissButton: alertItem.dismissButton)
    }
  }
}

#Preview{
  SigupView()
}
