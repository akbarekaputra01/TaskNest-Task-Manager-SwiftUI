//
//  TasksScreen.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 10/06/24.
//

import SwiftUI

struct TasksScreen: View {
  var body: some View {
    NavigationView {
      ZStack {
        ScrollView(.vertical, showsIndicators: false) {
          VStack(alignment: .leading, spacing: 20) {
            ForEach(MockData.tasks.prefix(5), id: \.id) { task in
              TodaysTasksCardView(tasks: task)
            }
          }
          .padding(.horizontal)
        }

        .navigationBarTitle("Tasks", displayMode: .inline)
      }
    }
  }
}

#Preview{
  TasksScreen()
}
