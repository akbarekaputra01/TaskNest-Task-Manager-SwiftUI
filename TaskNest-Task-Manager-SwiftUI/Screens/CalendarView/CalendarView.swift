//
//  CalendarView.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 09/06/24.
//

import SwiftUI

struct CalendarView: View {
  @StateObject var viewModel = CalendarViewModel()

  var body: some View {
    VStack(alignment: .leading) {
      DatePicker(
        "",
        selection: $viewModel.selectedDate,
        displayedComponents: .date
      )
      .datePickerStyle(.graphical)
      .padding(.horizontal)

      Text("Tasks on \(viewModel.formattedSelectedDate)")
        .frame(width: .infinity, alignment: .leading)
        .font(.title3)
        .fontWeight(.semibold)
        .padding(.horizontal)
        .padding(.top)

      if viewModel.tasksOnSelectedDate.isEmpty {
        Text("No tasks found on \(viewModel.formattedSelectedDate)")
          .foregroundColor(.gray)
          .padding(.leading)
      } else {
        ScrollView(.vertical, showsIndicators: false) {
          VStack(alignment: .leading, spacing: 22) {
            ForEach(
              viewModel.tasksOnSelectedDate, id: \.id
            ) {
              task in
              LargeTaskCard(viewModel: LargeTaskCardViewModel(task: task))
            }
          }
          .padding()
        }
      }

      Spacer()
    }
  }
}

#Preview{
  CalendarView()
}
