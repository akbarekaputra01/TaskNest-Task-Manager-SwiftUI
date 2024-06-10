//
//  HomeScreen.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 09/06/24.
//

import SwiftUI

struct HomeScreen: View {
  var body: some View {
    NavigationView {
      VStack {
        Text("Your Content Here")
      }
      .navigationBarTitle("Home", displayMode: .inline)
      .navigationBarItems(
        trailing:
          Button(action: {
            print("notif button clicked")
          }) {
            Image(systemName: "bell")
              .notificationButtonStyle()
              .notifBadgeExt(count: 9)
          }
      )
    }
  }
}

#Preview{
  HomeScreen()
}
