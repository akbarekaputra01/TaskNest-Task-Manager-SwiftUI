//
//  HomeViewModel.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 13/06/24.

import SwiftUI

final class HomeViewModel: ObservableObject {
  @Published var dateNow: String
  @Published var isShowingTodaysTasksScreen: Bool
  @Published var priorityTask: [TaskNest]
  @Published var threeTasksToday: ArraySlice<TaskNest>

  init() {
    self.isShowingTodaysTasksScreen = false
    self.priorityTask = []
    self.threeTasksToday = []

    self.dateNow = DateUtils.formattedDDMMYYYY(selectedDate: Date())
    self.priorityTask = MockData.tasks.filter { $0.priorityLevel == "High" }
    self.threeTasksToday = MockData.tasks.filter { $0.taskDate == dateNow }.prefix(3)
  }
}
