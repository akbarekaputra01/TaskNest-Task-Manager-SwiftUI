//
//  TaskNest.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 10/06/24.
//

import Foundation

struct TaskNest: Decodable, Identifiable {
    let id: Int
    let taskTitle: String
    let taskDescription: String
    let taskStartTime: String
    let taskEndTime: String
    let taskDate: String
    let taskCategory: String
    let priorityLevel: String
}

enum MockData {
    static let sampleTaskOne = TaskNest(
        id: 001,
        taskTitle: "Meeting with clients 1",
        taskDescription: "Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate.",
        taskStartTime: "6:00 PM",
        taskEndTime: "8:00 PM",
        taskDate: "12 Mar, 2024",
        taskCategory: "Work",
        priorityLevel: "High")

    static let sampleTaskTwo = TaskNest(
        id: 002,
        taskTitle: "Meeting with clients 2",
        taskDescription: "Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate.",
        taskStartTime: "6:00 PM",
        taskEndTime: "8:00 PM",
        taskDate: "12 Jun, 2024",
        taskCategory: "Home",
        priorityLevel: "Low")

    static let sampleTaskThree = TaskNest(
        id: 003,
        taskTitle: "Meeting with clients 3",
        taskDescription: "Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate.",
        taskStartTime: "6:00 PM",
        taskEndTime: "8:00 PM",
        taskDate: "12 Jun, 2024",
        taskCategory: "Health",
        priorityLevel: "High")

    static let sampleTaskFour = TaskNest(
        id: 004,
        taskTitle: "Meeting with clients 4",
        taskDescription: "Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate.",
        taskStartTime: "6:00 PM",
        taskEndTime: "8:00 PM",
        taskDate: "13 Jun, 2024",
        taskCategory: "Finance",
        priorityLevel: "Low")

    static let sampleTaskFive = TaskNest(
        id: 005,
        taskTitle: "Meeting with clients 5",
        taskDescription: "Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate.",
        taskStartTime: "6:00 PM",
        taskEndTime: "8:00 PM",
        taskDate: "11 Jun, 2024",
        taskCategory: "Work",
        priorityLevel: "High")

    static let sampleTaskSix = TaskNest(
        id: 006,
        taskTitle: "Meeting with clients 6",
        taskDescription: "Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate.",
        taskStartTime: "6:00 PM",
        taskEndTime: "8:00 PM",
        taskDate: "13 Jun, 2024",
        taskCategory: "Education",
        priorityLevel: "Low")

    static let tasks: [TaskNest] = [
        sampleTaskOne, sampleTaskTwo, sampleTaskThree,
        sampleTaskFour, sampleTaskFive, sampleTaskSix,
        sampleTaskOne, sampleTaskTwo, sampleTaskThree,
        sampleTaskFour, sampleTaskFive, sampleTaskSix,
    ]
}
