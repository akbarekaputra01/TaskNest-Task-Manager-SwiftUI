//
//  User.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 15/06/24.
//

import SwiftUI

struct User: Codable, Identifiable {
    var id: String = ""
    var name: String = ""
    var username: String = ""
    var email: String = ""
    var password: String = ""
    var imageUrl: String = ""
    var createdAt = Date()
}

enum MockUserData {
    static let sampleUser = User(
        id: "1",
        name: "Barr",
        username: "eka",
        email: "hahahah@gmail.com",
        password: "11223344",
        imageUrl: "profPict"
    )
}
