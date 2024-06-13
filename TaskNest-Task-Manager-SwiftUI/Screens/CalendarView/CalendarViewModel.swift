//
//  CalendarViewModel.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 13/06/24.
//

import SwiftUI

final class CalendarViewModel: ObservableObject {
  @Published var selectedDate: Date
  @Published var formattedSelectedDate: String
  @Published var tasksOnSelectedDate: [TaskNest]

  init() {
    self.selectedDate = Date()
    self.formattedSelectedDate = ""
    self.tasksOnSelectedDate = []

    self.formattedSelectedDate = DateUtils.formattedDDMMYYYY(selectedDate: self.selectedDate)
    self.tasksOnSelectedDate = MockData.tasks.filter {
      $0.taskDate == self.formattedSelectedDate
    }
  }
}
