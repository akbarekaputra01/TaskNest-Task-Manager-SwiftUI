//
//  User.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 15/06/24.
//

import SwiftUI

struct GuestUser: Codable, Identifiable {
    var id: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var imageUrl: String = ""
    var createdAt: Date = .init()
}

struct User: Codable, Identifiable {
    var id: String = ""
    var name: String = ""
    var username: String = ""
    var email: String = ""
    var password: String = ""
    var imageUrl: String = ""
    var createdAt: Date = .init()
}
