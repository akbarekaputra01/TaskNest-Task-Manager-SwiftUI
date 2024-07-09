//
//  SignUpView.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 15/06/24.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject var viewModel = SignUpViewModel()

    @FocusState private var focusedTextField: FormTextField?
    enum FormTextField {
        case name, username, email, password, confirmPassword
    }

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        VStack(alignment: .leading, spacing: 22) {
                            HStack {
                                Text("Sign Up")
                                    .font(.largeTitle)
                                    .bold()
                                
                                Spacer()
                                
                                if let image = viewModel.signUpImage {
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
                                        ImagePicker(image: $viewModel.signUpImage)
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
                            
                            TextField("Username", text: $viewModel.user.username)
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
                            
                            SecureField("Confirm Password", text: $viewModel.confirmPassword)
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
                                viewModel.signUp {
                                    presentationMode.wrappedValue.dismiss()
                                }
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
                                viewModel.user.name.isEmpty
                                    || viewModel.user.username.isEmpty
                                    || viewModel.user.email.isEmpty
                                    || viewModel.user.password.count < 6
                                    || viewModel.confirmPassword.count < 6
                                    || !viewModel.isAgree
                            )
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .opacity(
                                viewModel.user.name.isEmpty
                                    || viewModel.user.username.isEmpty
                                    || viewModel.user.email.isEmpty
                                    || viewModel.user.password.count < 6
                                    || viewModel.confirmPassword.count < 6
                                    || !viewModel.isAgree ? 0.5 : 1
                            )
                            
                            PlatformSignInView(presentationMode: presentationMode)
                        }
                        .padding()
                    }
                    .padding(.bottom)
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
                // To unable scroll the scrollview
                // Note: scrollView used because after "enter" between TextField and SecureField, screen is like bounce
                .environment(\.isScrollEnabled, false)
                
                // To limiting height the scrollView is just one screen
                .frame(height: geometry.size.height)
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(
                title: alertItem.title,
                message: alertItem.message,
                dismissButton: alertItem.dismissButton
            )
        }
    }
}

#Preview {
    SignUpView()
}
