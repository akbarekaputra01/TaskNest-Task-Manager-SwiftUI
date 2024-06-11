//
//  TodaysTasks.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 12/06/24.
//

import SwiftUI

struct TodaysTasksScreen: View {
  // to close this screen
  @Environment(\.presentationMode) var presentationMode

  let dateNow = DateUtils.formattedDDMMYYYY(selectedDate: Date())

  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .leading, spacing: 22) {
          ForEach(MockData.tasks, id: \.id) { task in
            if task.taskDate == dateNow {
              TodaysTasksCardView(tasks: task)
            }
          }
        }
        .padding(.horizontal)
        .padding(.top)
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
  }
}

#Preview{
  TodaysTasksScreen()
}
//
