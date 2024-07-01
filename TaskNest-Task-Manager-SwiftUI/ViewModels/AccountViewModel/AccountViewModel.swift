//
//  AccountViewModel.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 14/06/24.
//

import SwiftUI

final class AccountViewModel: ObservableObject {
    @AppStorage("user") private var userData: Data?
    @Published var user = GuestUser()
    @Published var alertItem: AlertItem?

    func saveChanges() {
        do {
            let data = try JSONEncoder().encode(user)
            userData = data
        } catch {
            alertItem = AlertContext.invalidUserData
        }
    }

    func retrieveUser() {
        guard let userData else { return }

        do {
            user = try JSONDecoder().decode(GuestUser.self, from: userData)
        } catch {
            alertItem = AlertContext.invalidUserData
        }
    }
}
