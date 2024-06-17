//
//  TasksViewModel.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 13/06/24.
//

import SwiftUI

final class TasksViewModel: ObservableObject {
  @Published var isShowingCreateTaskScreen: Bool
  @Published var allTasks: [TaskNest]

  init() {
    self.allTasks = []

    self.isShowingCreateTaskScreen = false
    self.allTasks = MockData.tasks
  }
}
