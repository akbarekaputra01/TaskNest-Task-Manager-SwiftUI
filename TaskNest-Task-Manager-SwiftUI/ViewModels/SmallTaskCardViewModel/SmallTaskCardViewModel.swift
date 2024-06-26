//
//  SmallTaskCardViewModel.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 13/06/24.
//

import SwiftUI

final class SmallTaskCardViewModel: ObservableObject {
    @Published var task: TaskNest
    @Published var taskCategory: String
    @Published var taskTitle: String
    @Published var taskDate: String
    @Published var taskStartTime: String

    init(task: TaskNest) {
        self.task = task

        self.taskCategory = task.taskCategory
        self.taskTitle = task.taskTitle
        self.taskDate = task.taskDate
        self.taskStartTime = task.taskStartTime
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

    var formattedDateAndTime: String {
        return "\(self.taskDate) at \(self.taskStartTime)"
    }

    func onViewDetailsTapped() {
        print("View details tapped")
    }
}
