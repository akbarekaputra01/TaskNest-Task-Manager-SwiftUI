//
//  HomeView.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 09/06/24.
//

import SwiftUI

struct HomeView: View {
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

        let priorityTask = MockData.tasks.filter { $0.priorityLevel == "High" }

        if priorityTask.isEmpty {
          Text("No priority tasks found")
            .foregroundColor(.gray)
            .padding(.leading)
        } else {
          ScrollView(.horizontal, showsIndicators: false) {
            HStack {
              ForEach(priorityTask, id: \.id) { task in
                SmallTaskCard(tasks: task)
              }
            }
            .frame(height: 175)
            .padding(.leading, 3)
            .padding(.trailing, 10)
          }
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
          let threeTasksToday = MockData.tasks.filter { $0.taskDate == dateNow }.prefix(3)

          if threeTasksToday.isEmpty {
            Text("No tasks found for today")
              .foregroundColor(.gray)
          } else {
            ForEach(threeTasksToday, id: \.id) { task in
              LargeTaskCard(tasks: task)
            }
          }
        }
        .padding(.horizontal)

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
          TodaysTasksView()
        }
      )
    }
  }
}

#Preview{
  HomeView()
}
