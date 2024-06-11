//
//  HomeScreen.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 09/06/24.
//

import SwiftUI

struct HomeScreen: View {
  let dateNow = DateUtils.formattedDDMMYYYY(selectedDate: Date())
  @State var isShowingTodaysTasksScreen: Bool = false

  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        Text("Top Priority Tasks")
          .padding(.leading)
          .frame(maxWidth: .infinity, alignment: .leading)
          .font(.title3)
          .fontWeight(.semibold)

        ScrollView(.horizontal, showsIndicators: false) {
          HStack {
            ForEach(MockData.tasks, id: \.id) { task in
              if task.priorityLevel == "High" {
                TopPriorityTasksCardView(tasks: task)
              }
            }
          }
          .frame(height: 170)
          .padding(.leading, 3)
          .padding(.trailing, 10)
        }

        HStack {
          Text("Today's Tasks")
            .font(.title3)
            .fontWeight(.semibold)
          Spacer()
          Button(
            action: {
              isShowingTodaysTasksScreen.toggle()
            },
            label: {
              Text("See all")
                .foregroundColor(.gray)
            })
        }
        .padding(.horizontal)
        .padding(.top)

        VStack(spacing: 22) {
          // filtering and limiting data
          ForEach(MockData.tasks.filter { $0.taskDate == dateNow }.prefix(3), id: \.id) {
            task in
            TodaysTasksCardView(tasks: task)
          }
        }
        .padding(.horizontal)
        .padding(.top, 5)

        Spacer()
      }

      .navigationBarTitle("Home", displayMode: .inline)
      .navigationBarItems(
        trailing:
          Button(action: {
            print("notif button clicked")
          }) {
            Image(systemName: "bell")
              .outlineButtonExt()
              .notifBadgeExt(count: 94)
              .padding(.bottom, 10)
          }
      )
      .fullScreenCover(
        isPresented: $isShowingTodaysTasksScreen,
        content: {
          TodaysTasksScreen()
        }
      )
    }
  }
}

#Preview{
  HomeScreen()
}
