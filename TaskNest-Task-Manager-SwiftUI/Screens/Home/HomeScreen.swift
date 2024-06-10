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
      ZStack {
        VStack(alignment: .leading) {
          Text("Top Priority Tasks")
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.title3)
            .fontWeight(.semibold)
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
              TopPriorityTasksCardView(
                category: "work", task: "Meeting with clients", time: "19 Mar, 2024 at 7:30 PM")
              TopPriorityTasksCardView(
                category: "education", task: "Meeting with clients", time: "19 Mar, 2024 at 7:30 PM"
              )
              TopPriorityTasksCardView(
                category: "health", task: "Meeting with clients", time: "19 Mar, 2024 at 7:30 PM")
              TopPriorityTasksCardView(
                category: "home", task: "Meeting with clients", time: "19 Mar, 2024 at 7:30 PM")
            }
            .frame(height: 170)
            .padding(.leading, 3)
          }

          Spacer()
        }
        .padding()
      }
      .navigationBarTitle("Home", displayMode: .inline)
      .navigationBarItems(
        trailing:
          Button(action: {
            print("notif button clicked")
          }) {
            Image(systemName: "bell")
              .outlineButtonStyle()
              .notifBadgeExt(count: 9)
          }
      )
    }
  }
}

#Preview{
  HomeScreen()
}
