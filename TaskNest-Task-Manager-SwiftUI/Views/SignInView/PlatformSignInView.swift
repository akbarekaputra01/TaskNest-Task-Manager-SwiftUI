//
//  PlatformSignInView.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 05/07/24.
//

import SwiftUI

struct PlatformSignInView: View {
    @Binding var presentationMode: PresentationMode

    @StateObject var viewModel = SignInViewModel()

    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 1)
            Text("Or sign in with")
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
                print("Google Sign In Button is clicked")

                viewModel.isLoading = true

                viewModel.signInWithGoogle(withPresenting: Application_utility.rootViewController) {
                    viewModel.isLoading = false
                    $presentationMode.wrappedValue.dismiss()
                }
            } label: {
                ZStack {
                    if !viewModel.isLoading {
                        Image("googleIcon")
                            .frame(width: 5)

                    } else {
                        ProgressView()
                            .frame(width: 5)
                            .progressViewStyle(CircularProgressViewStyle(tint: .accent))
                        // .scaleEffect(1.25)
                    }
                }
                .padding(20)
                .overlay(
                    Circle()
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
            }
            .disabled(viewModel.isLoading)
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
    }
}

#Preview {
    PlatformSignInView(presentationMode: SignInView().presentationMode)
}
