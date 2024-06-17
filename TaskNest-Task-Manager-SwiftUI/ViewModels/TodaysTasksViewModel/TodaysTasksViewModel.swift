//
//  TodaysTasksViewModel.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 13/06/24.
//

import SwiftUI

final class TodaysTasksViewModel: ObservableObject {
  @Published var dateNow: String
  @Published var todayTasks: [TaskNest]

  init() {
    self.todayTasks = []

    self.dateNow = DateUtils.formattedDDMMYYYY(selectedDate: Date())
    self.todayTasks = MockData.tasks.filter { $0.taskDate == dateNow }
  }
}
