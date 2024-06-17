//
//  AccountViewModel.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 14/06/24.
//

import Foundation

final class AccountViewModel: ObservableObject {
  @Published var firstName = ""
  @Published var lastName = ""
  @Published var email = ""
  @Published var birthdate = Date()
}
