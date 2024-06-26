//
//  LargeTaskCardViewModel.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 13/06/24.
//

import SwiftUI

final class LargeTaskCardViewModel: ObservableObject {
    @Published var task: TaskNest
    @Published var taskCategory: String
    @Published var taskTitle: String
    @Published var taskDescription: String
    @Published var taskDate: String
    @Published var taskStartTime: String
    @Published var taskEndTime: String

    init(task: TaskNest) {
        self.task = task

        self.taskCategory = task.taskCategory
        self.taskTitle = task.taskTitle
        self.taskDescription = task.taskDescription
        self.taskDate = task.taskDate
        self.taskStartTime = task.taskStartTime
        self.taskEndTime = task.taskEndTime
    }

    var categoryImageSystemName: String {
        switch self.taskCategory {
        case "Work":
            return "handbag.fill"
        case "Home":
            return "house.fill"
        case "Finance":
            return "dollarsign"
        case "Education":
            return "book.fill"
        case "Health":
            return "figure.disc.sports"
        default:
            return "camera.metering.unknown"
        }
    }

    var formattedTaskTime: String {
        return "\(self.taskStartTime) - \(self.taskEndTime)"
    }

    func onViewDetailsTapped() {
        print("View details tapped")
    }
}
