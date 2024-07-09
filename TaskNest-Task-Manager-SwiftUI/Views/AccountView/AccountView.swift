//
//  AccountView.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 13/06/24.
//

import SwiftUI

struct AccountView: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject var viewModel = AccountViewModel()

    @FocusState private var focusedTextField: FormTextField?
    enum FormTextField {
        case name, username, email
    }

    var body: some View {
        NavigationView {
            VStack {
                AsyncImage(url: URL(string: viewModel.user.imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .padding(8)
                        .overlay(
                            Circle().stroke(Color.accentColor.opacity(0.5), lineWidth: 2)
                        )
                        .padding()
                } placeholder: {
                    Image("blankPP")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .padding(8)
                        .overlay(
                            Circle().stroke(Color.accentColor.opacity(0.5), lineWidth: 2)
                        )
                        .padding()
                }

                Form {
                    Section(header: Text("Personal Info")) {
                        TextField("Name", text: $viewModel.user.name)
                            .focused($focusedTextField, equals: .name)
                            .onSubmit { focusedTextField = .username }
                            .submitLabel(.next)
                            .disabled(!viewModel.user.email.isEmpty)

                        TextField("Username", text: $viewModel.user.username)
                            .focused($focusedTextField, equals: .username)
                            .onSubmit { focusedTextField = .email }
                            .submitLabel(.next)
                            .disabled(!viewModel.user.email.isEmpty)

                        if !viewModel.user.email.isEmpty {
                            TextField("Email", text: $viewModel.user.email)
                                .focused($focusedTextField, equals: .email)
                                .onSubmit { focusedTextField = nil }
                                .submitLabel(.continue)
                                .disabled(!viewModel.user.email.isEmpty)

                            Button {
                                viewModel.signOut()
                            } label: {
                                Text("Sign Out")
                                    .fontWeight(.bold)
                            }
                        }

                        if viewModel.user.email.isEmpty {
                            Button {
                                viewModel.updateUserData(user: viewModel.user) {
                                    viewModel.alertItem = AlertContext.userSaveSuccess
                                }
                            } label: {
                                Text("Save changes")
                                    .fontWeight(.bold)
                            }
                            Button(action: {
                                viewModel.isSignInViewShown.toggle()
                            }, label: {
                                Text("Sign In not as a guest")
                                    .fontWeight(.bold)
                                    .foregroundColor(.accentColor)
                            })
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .scrollDisabled(true)

                Spacer()
            }
            .navigationBarTitle("Profile", displayMode: .inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Dismiss") { focusedTextField = nil }
                }
            }
        }
        .fullScreenCover(isPresented: $viewModel.isSignInViewShown, content: {
            SignInView()
        })
        .onChange(of: viewModel.userData, initial: true) { oldValue, newValue in
            viewModel.getUser()
            // debugging to fixing bug
            print("old: \(String(describing: oldValue))")
            print("new: \(String(describing: newValue))")
            print("onchange is working")
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
    AccountView()
}
