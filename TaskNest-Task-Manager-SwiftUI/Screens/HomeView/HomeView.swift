//
//  HomeView.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 09/06/24.
//

import SwiftUI

struct HomeView: View {
  @StateObject var viewModel = HomeViewModel()

  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        Text("Top Priority Tasks")
          .padding(.leading)
          .frame(maxWidth: .infinity, alignment: .leading)
          .font(.title3)
          .fontWeight(.semibold)

        if viewModel.priorityTask.isEmpty {
          Text("No priority tasks found")
            .foregroundColor(.gray)
            .padding(.leading)
        } else {
          ScrollView(.horizontal, showsIndicators: false) {
            HStack {
              ForEach(viewModel.priorityTask, id: \.id) { task in
                let viewModel = SmallTaskCardViewModel(task: task)
                SmallTaskCard(viewModel: viewModel)
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
              viewModel.isShowingTodaysTasksScreen.toggle()
            },
            label: {
              Text("See all")
                .foregroundColor(.gray)
            })
        }
        .padding(.horizontal)
        .padding(.top)

        VStack(spacing: 22) {
          if viewModel.threeTasksToday.isEmpty {
            Text("No tasks found for today")
              .foregroundColor(.gray)
          } else {
            ForEach(viewModel.threeTasksToday, id: \.id) { task in
              LargeTaskCard(viewModel: LargeTaskCardViewModel(task: task))
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
        isPresented: $viewModel.isShowingTodaysTasksScreen,
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
