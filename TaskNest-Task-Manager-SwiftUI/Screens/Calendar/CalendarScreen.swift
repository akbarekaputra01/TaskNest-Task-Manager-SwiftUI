//
//  CalendarScreen.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 09/06/24.
//

import SwiftUI

struct CalendarScreen: View {
  @State private var selectedDate = Date()

  var body: some View {
    VStack(alignment: .leading) {
      DatePicker(
        "",
        selection: $selectedDate,
        displayedComponents: .date
      )
      .datePickerStyle(.graphical)
      .padding(.horizontal)

      Text("Tasks on \(DateUtils.formattedDDMMYYYY(selectedDate: selectedDate))")
        .frame(width: .infinity, alignment: .leading)
        .font(.title3)
        .fontWeight(.semibold)
        .padding(.horizontal)
        .padding(.top)

      ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .leading, spacing: 22) {
          ForEach(
            MockData.tasks.filter {
              $0.taskDate == DateUtils.formattedDDMMYYYY(selectedDate: selectedDate)
            }.prefix(3), id: \.id
          ) {
            task in
            TodaysTasksCardView(tasks: task)
          }
        }
        .padding(.vertical)
        .padding(.horizontal)
      }

      Spacer()
    }
  }
}

#Preview{
  CalendarScreen()
}
//
