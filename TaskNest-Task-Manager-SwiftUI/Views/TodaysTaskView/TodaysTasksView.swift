//
//  TodaysTasksView.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 12/06/24.
//

import SwiftUI

struct TodaysTasksView: View {
  // to close this screen
  @Environment(\.presentationMode) var presentationMode

  @StateObject var viewModel = TodaysTasksViewModel()

  var body: some View {
    NavigationView {
      VStack {
        if viewModel.todayTasks.isEmpty {
          Spacer()
          Text("No tasks found for today")
            .foregroundColor(.gray)
          Spacer()
        } else {
          ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 22) {
              ForEach(viewModel.todayTasks, id: \.id) { task in
                LargeTaskCardView(viewModel: LargeTaskCardViewModel(task: task))
              }
            }
            .padding(.horizontal)
            .padding(.top)
          }
        }
      }

      .navigationBarTitle("Today's Tasks", displayMode: .inline)
      .navigationBarItems(
        leading:
          Button(action: {
            // to close this screen
            presentationMode.wrappedValue.dismiss()
          }) {
            Image(systemName: "chevron.backward")
              .resizable()
              .scaledToFit()
              .frame(height: 20)
              .foregroundColor(Color.primary)
              .padding(.vertical)
          })
    }
    .onAppear {
      _ = viewModel.dateNow
    }
  }
}

#Preview{
  TodaysTasksView()
}
