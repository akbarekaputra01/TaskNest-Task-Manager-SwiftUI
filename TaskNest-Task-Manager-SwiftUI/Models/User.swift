//
//  User.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 15/06/24.
//

import SwiftUI

import Foundation

struct User: Codable, Identifiable {
    var id: String
    var name: String
    var username: String
    var email: String
    var password: String
    var imageUrl: String
    var createdAt: Date

    // Default initializer
    init(id: String = "", name: String = "", username: String = "", email: String = "",
         password: String = "", imageUrl: String = "", createdAt: Date = Date())
    {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.password = password
        self.imageUrl = imageUrl
        self.createdAt = createdAt
    }
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
