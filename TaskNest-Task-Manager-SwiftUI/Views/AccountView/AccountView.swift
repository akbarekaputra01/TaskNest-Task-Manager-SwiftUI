//
//  AccountView.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 13/06/24.
//

import SwiftUI

struct AccountView: View {
    @StateObject var viewModel = AccountViewModel()

    @FocusState private var focusedTextField: FormTextField?

    enum FormTextField {
        case firstName, lastName, email
    }

    var body: some View {
        NavigationView {
            VStack {
                Image("profPict")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                    .clipShape(Circle())
                    .padding(8)
                    .overlay(
                        Circle().stroke(Color.accentColor.opacity(0.5), lineWidth: 2)
                    )
                    .padding()

                Form {
                    Section(header: Text("Personal Info")) {
                        TextField("First Name", text: $viewModel.user.firstName)
                            .focused($focusedTextField, equals: .firstName)
                            .onSubmit { focusedTextField = .lastName }
                            .submitLabel(.next)

                        TextField("Last Name", text: $viewModel.user.lastName)
                            .focused($focusedTextField, equals: .lastName)
                            .onSubmit { focusedTextField = .email }
                            .submitLabel(.next)

//                            TextField("Email", text: $viewModel.email)
//                                .focused($focusedTextField, equals: .email)
//                                .onSubmit { focusedTextField = nil }
//                                .submitLabel(.continue)
//                                .keyboardType(.emailAddress)
//                                .autocapitalization(.none)
//                                .disableAutocorrection(true)

                        Button {
                            viewModel.saveChanges()
                        } label: {
                            Text("Save changes")
                                .fontWeight(.bold)
                        }

                        NavigationLink(destination: SignUpView().navigationBarBackButtonHidden()) {
                            Text("Login not as a guest")
                                .fontWeight(.bold)
                                .foregroundColor(.accentColor)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .scrollDisabled(true)

                Spacer()
            }
            .navigationBarTitle("Guest Profile", displayMode: .inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Dismiss") { focusedTextField = nil }
                }
            }
        }
        .onAppear {
            viewModel.retrieveUser()
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
