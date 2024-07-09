//
//  Alert.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 15/06/24.
//

import SwiftUI

struct AlertItem: Identifiable, Equatable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button

    static func == (lhs: AlertItem, rhs: AlertItem) -> Bool {
        lhs.id == rhs.id
    }
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
        title: Text("Invalid User Data"),
        message: Text("Plase ensure your data is correct."),
        dismissButton: .default(Text("OK")))

    static let registrationError = AlertItem(
        title: Text("Registration Error"),
        message: Text("An error occurred while regitering."),
        dismissButton: .default(Text("OK")))

    static let signInError = AlertItem(
        title: Text("Sign In Error"),
        message: Text("An error occurred while sign in."),
        dismissButton: .default(Text("OK")))

    static let fetchingDataError = AlertItem(
        title: Text("Fetching Data Error"),
        message: Text("An error occurred while fetching data"),
        dismissButton: .default(Text("OK")))

    static let createUserError = AlertItem(
        title: Text("Error createUserAuth"),
        message: Text("An error occurred while create user auth"),
        dismissButton: .default(Text("OK")))

    static let uploadImgToStorageError = AlertItem(
        title: Text("Error uploadImageToStorage"),
        message: Text("An error occurred while uploading image to storage"),
        dismissButton: .default(Text("OK")))

    static let deleteUserError = AlertItem(
        title: Text("Delete User Error"),
        message: Text("An error occurred while deleting user."),
        dismissButton: .default(Text("OK")))

    static let getImageUrlError = AlertItem(
        title: Text("Error getImageUrl"),
        message: Text("An error occurred while getting image url."),
        dismissButton: .default(Text("OK")))

    static let uploadUserDataToDBError = AlertItem(
        title: Text("Error uploadUserDataToDB"),
        message: Text("An error occurred while uploading user data to database."),
        dismissButton: .default(Text("OK")))

    static let userRegistSuccess = AlertItem(
        title: Text("Registration Successful"),
        message: Text("Your account has been created successfully. Please sign in to continue."),
        dismissButton: .default(Text("OK")))

    static let userSaveSuccess = AlertItem(
        title: Text("Guest Profile Saved"),
        message: Text("Your guest profile information was successfully saved."),
        dismissButton: .default(Text("OK")))

    static let signInSuccess = AlertItem(
        title: Text("Sign In Successful"),
        message: Text("You have successfully sign in."),
        dismissButton: .default(Text("OK")))

    static let signOutSuccess = AlertItem(
        title: Text("Sign Out Successful"),
        message: Text("You have successfully sign out."),
        dismissButton: .default(Text("OK")))

    static let userDocDoesntExist = AlertItem(
        title: Text("User Doc Doesn't Exist"),
        message: Text("User document does not exist"),
        dismissButton: .default(Text("OK")))
}
