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
                        VStack(alignment: .leading, spacing: 22) {
                            TextField("First Name", text: $viewModel.firstName)
                                .focused($focusedTextField, equals: .firstName)
                                .onSubmit { focusedTextField = .lastName }
                                .submitLabel(.next)

                            TextField("Last Name", text: $viewModel.lastName)
                                .focused($focusedTextField, equals: .lastName)
                                .onSubmit { focusedTextField = .email }
                                .submitLabel(.next)

                            TextField("Email", text: $viewModel.email)
                                .focused($focusedTextField, equals: .email)
                                .onSubmit { focusedTextField = nil }
                                .submitLabel(.continue)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)

                            DatePicker(
                                "Birthday",
                                selection: $viewModel.birthdate,
                                in: Date().oneHundredTenYearsAgo ... Date().eighteenYearsAgo,
                                displayedComponents: .date
                            )

                            Button {
                                // action
                            } label: {
                                Text("Save Changes")
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .frame(height: 500)
                .scrollDisabled(true)

                Spacer()
            }
            .navigationBarTitle("Profile", displayMode: .inline)
            .navigationBarItems(
                trailing:
                Button(action: {
                    print("edit button clicked")
                }) {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                        .foregroundColor(.primary)
                }
            )
        }
    }
}

#Preview {
    AccountView()
}
