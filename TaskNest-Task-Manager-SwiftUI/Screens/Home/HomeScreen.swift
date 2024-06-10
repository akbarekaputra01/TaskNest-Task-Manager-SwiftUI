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
        ScrollView(.vertical, showsIndicators: false) {
          VStack(alignment: .leading) {

            Text("Top Priority Tasks")
              .padding(.leading)
              .frame(maxWidth: .infinity, alignment: .leading)
              .font(.title3)
              .fontWeight(.semibold)
            ScrollView(.horizontal, showsIndicators: false) {
              HStack {
                TopPriorityTasksCardView(
                  category: "work", task: "Meeting with clients", time: "19 Mar, 2024 at 7:30 PM")
                TopPriorityTasksCardView(
                  category: "education", task: "Meeting with clients",
                  time: "19 Mar, 2024 at 7:30 PM"
                )
                TopPriorityTasksCardView(
                  category: "health", task: "Meeting with clients", time: "19 Mar, 2024 at 7:30 PM")
                TopPriorityTasksCardView(
                  category: "home", task: "Meeting with clients", time: "19 Mar, 2024 at 7:30 PM")
              }
              .frame(height: 170)
              .padding(.leading, 3)
              .padding(.trailing, 10)
            }

            VStack(spacing: 20) {
              HStack {
                Text("Today's Tasks")
                  .font(.title3)
                  .fontWeight(.semibold)

                Spacer()

                Text("See all")
                  .font(.system(size: 16))
                  .foregroundColor(.black.opacity(0.5))
              }
              .padding(.top, 10)
              TodaysTasksCardView(
                taskCategory: "work",
                taskTitle: "Preparations",
                taskDescription:
                  "Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate.",
                taskTime: "7:30 AM - 8:00 AM")
              TodaysTasksCardView(
                taskCategory: "education",
                taskTitle: "Preparations",
                taskDescription:
                  "Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate.",
                taskTime: "7:30 AM - 8:00 AM")
              TodaysTasksCardView(
                taskCategory: "home",
                taskTitle: "Preparations",
                taskDescription:
                  "Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate.",
                taskTime: "7:30 AM - 8:00 AM")
              TodaysTasksCardView(
                taskCategory: "work",
                taskTitle: "Preparations",
                taskDescription:
                  "Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate.",
                taskTime: "7:30 AM - 8:00 AM")
            }
            .padding(.horizontal)
          }
        }

        .navigationBarTitle("Home", displayMode: .inline)
        .navigationBarItems(
          trailing:
            Button(action: {
              print("notif button clicked")
            }) {
              Image(systemName: "bell")
                .outlineButtonStyle()
                .notifBadgeExt(count: 90)
                .padding(.bottom, 10)
            }

        )

      }
    }
  }
}

#Preview{
  HomeScreen()
}
