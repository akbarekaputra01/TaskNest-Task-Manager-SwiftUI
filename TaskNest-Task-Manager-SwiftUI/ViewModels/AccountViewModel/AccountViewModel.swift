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

    func updateUserData(user: User, closure: @escaping () -> Void) {
        guard !user.name.isEmpty && !user.username.isEmpty else {
            alertItem = AlertContext.invalidForm
            return
        }

        do {
            let data = try JSONEncoder().encode(user)
            userData = data
            closure()
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

            user = User()
            updateUserData(user: user) {
                self.alertItem = AlertContext.signOutSuccess
            }
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}
