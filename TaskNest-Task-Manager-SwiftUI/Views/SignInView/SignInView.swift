//
//  SignInView.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 01/07/24.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject var viewModel = SignInViewModel()

    @FocusState private var focusedTextField: FormTextField?
    enum FormTextField {
        case email, password
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 22) {
                HStack {
                    Spacer()
                    Text("Sign In")
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
                    .focused($focusedTextField, equals: .email)
                    .onSubmit { focusedTextField = .password }
                    .submitLabel(.next)

                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .focused($focusedTextField, equals: .password)
                    .onSubmit { focusedTextField = nil }
                    .submitLabel(.next)

                Button(action: {
                    viewModel.signIn()
                }) {
                    Text("Sign In")
                        .fontWeight(.bold)
                }
                .disabled(
                    viewModel.email.isEmpty || viewModel.password.count < 6
                )
                .padding()
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(10)
                .opacity(
                    viewModel.email.isEmpty || viewModel.password.count < 6 ? 0.5 : 1
                )

                PlatformSignInView(presentationMode: self.presentationMode)

                HStack {
                    Spacer()
                    Text("Don't have an account?")
                    NavigationLink(destination: SignUpView().navigationBarBackButtonHidden()) {
                        Text("Sign Up")
                            .fontWeight(.bold)
                    }
                    Spacer()
                }
            }
            .padding()
            .navigationBarItems(
                leading:
                Button(action: {
                    // to close this screen
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                        .foregroundColor(Color.accentColor)
                        .padding(.vertical)
                }
            )
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(
                title: alertItem.title,
                message: alertItem.message,
                dismissButton: alertItem.dismissButton
            )
        }
        // to closing screen after click "okay" on notification
        .onChange(of: viewModel.alertItem, initial: true) { newValue, _ in
            if newValue == AlertContext.signInSuccess {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    SignInView()
}
