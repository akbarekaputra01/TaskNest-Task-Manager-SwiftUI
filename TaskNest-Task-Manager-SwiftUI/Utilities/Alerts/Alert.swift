//
//  Alert.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 15/06/24.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

enum AlertContext {
    static let invalidForm = AlertItem(
        title: Text("Invalid Form"),
        message: Text("Please ensure all fields in the form have been filled out."),
        dismissButton: .default(Text("OK")))

    static let invalidEmail = AlertItem(
        title: Text("Invalid Email"),
        message: Text("Please ensure your email is correct."),
        dismissButton: .default(Text("OK")))

    static let invalidRegistPassword = AlertItem(
        title: Text("Invalid Password"),
        message: Text("Passwords do not match."),
        dismissButton: .default(Text("OK")))

    static let invalidAgreement = AlertItem(
        title: Text("Invalid Agreement"),
        message: Text("Please accept the agreement to continue."),
        dismissButton: .default(Text("OK")))

    static let invalidUserData = AlertItem(
        title: Text("Profile Error"),
        message: Text("There was an error saving or retrieving your profile."),
        dismissButton: .default(Text("OK")))

    static let invalidRegist = AlertItem(
        title: Text("Registration Error"),
        message: Text("An error occurred when regitering."),
        dismissButton: .default(Text("OK")))

    static let userRegistSuccess = AlertItem(
        title: Text("Registration Successful"),
        message: Text("Your profile information was successfully saved."),
        dismissButton: .default(Text("OK")))

    static let userSaveSuccess = AlertItem(
        title: Text("Guest Profile Saved"),
        message: Text("Your guest profile information was successfully saved."),
        dismissButton: .default(Text("OK")))
}
