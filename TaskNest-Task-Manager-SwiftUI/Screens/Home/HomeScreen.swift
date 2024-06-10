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
                ForEach(MockData.tasks, id: \.id) { task in
                  if task.priorityLevel == "high" {
                    TopPriorityTasksCardView(tasks: task)
                  }
                }
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

                Button(
                  action: { print("cliked") },
                  label: {
                    Text("See all")
                      .font(.system(size: 16))
                      .foregroundColor(.black.opacity(0.5))
                  })
              }
              .padding(.top, 10)

              ForEach(MockData.tasks.prefix(5), id: \.id) { task in
                TodaysTasksCardView(tasks: task)
              }
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
