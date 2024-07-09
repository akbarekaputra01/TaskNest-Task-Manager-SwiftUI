//
//  AccountViewModel.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 14/06/24.
//

import FirebaseAuth
import SwiftUI

final class AccountViewModel: ObservableObject {
    @AppStorage("user") var userData: Data?
    @Published var user = User()
    @Published var alertItem: AlertItem?
    @Published var isSignInViewShown: Bool = false

    func updateUserData(user: User, closure: @escaping (Error?) -> Void) {
        guard !user.name.isEmpty && !user.username.isEmpty else {
            closure(FormError.invalidForm)
            return
        }

        do {
            let data = try JSONEncoder().encode(user)
            userData = data
            closure(nil)
        } catch {
            alertItem = AlertContext.invalidUserData
        }
    }

    func getUser() {
        guard let userData else { return }

        do {
            user = try JSONDecoder().decode(User.self, from: userData)
        } catch {
            alertItem = AlertContext.invalidUserData
        }
    }

    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()

//            // to reset the user
//            user = User()
//            updateUserData(user: user) { _ in // if no error occured
//                self.alertItem = AlertContext.signOutSuccess
//            }

            deleteUser {
                self.alertItem = AlertContext.signOutSuccess
            }

//            user = User()
//            userData = try JSONEncoder().encode(user)
//            alertItem = AlertContext.signOutSuccess
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }

    func deleteUser(closure: @escaping () -> Void) {
        user = User()

        do {
            let data = try JSONEncoder().encode(user)
            userData = data
            closure()
        } catch {
            alertItem = AlertContext.invalidUserData
        }
    }
}
