//
//  TasksScreen.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 10/06/24.
//

import SwiftUI

struct TasksScreen: View {
  @State var isShowingCreateTaskScreen: Bool = false

  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .leading, spacing: 22) {
          ForEach(MockData.tasks, id: \.id) { task in
            TodaysTasksCardView(tasks: task)
          }
        }
        .padding(.horizontal)
        .padding(.top)
      }

      .navigationBarTitle("Tasks", displayMode: .inline)
      .navigationBarTitle("Home", displayMode: .inline)
      .navigationBarItems(
        trailing:
          Button(
            action: {
              isShowingCreateTaskScreen.toggle()
            },
            label: {
              Image(systemName: "plus.app")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25)
                .foregroundColor(.isDark)
            })
      )
    }
    .fullScreenCover(
      isPresented: $isShowingCreateTaskScreen,
      content: {
        CreateTaskScreen()
      }
    )
  }
}

#Preview{
  TasksScreen()
}
