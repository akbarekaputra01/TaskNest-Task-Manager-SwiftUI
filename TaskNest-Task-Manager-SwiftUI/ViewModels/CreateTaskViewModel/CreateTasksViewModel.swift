//
//  CreateTasksViewModel.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 13/06/24.
//

import SwiftUI

final class CreateTasksViewModel: ObservableObject {
  @Published var taskTitle: String
  @Published var taskDescription: String
  @Published var selectedPriority: String

  init() {
    self.taskTitle = ""
    self.taskDescription = ""
    self.selectedPriority = "Medium"
  }
}
