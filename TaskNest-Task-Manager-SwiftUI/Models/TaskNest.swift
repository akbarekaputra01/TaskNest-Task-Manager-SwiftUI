//
//  TaskNest.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 10/06/24.
//

import Foundation

struct TaskNest: Decodable, Identifiable {
  let id: Int
  let taskName: String
  let taskDescription: String
  let taskTimeStart: String
  let taskTimeEnd: String
  let taskDate: String
  let taskCategory: String
  let priorityLevel: String
}

struct MockData {
  static let firstSampleTask = TaskNest(
    id: 001,
    taskName: "Meeting with clients 1",
    taskDescription: "Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate.",
    taskTimeStart: "6:00 PM",
    taskTimeEnd: "8:00 PM",
    taskDate: "19 Mar, 2024",
    taskCategory: "work",
    priorityLevel: "high")
  static let secondSampleTask = TaskNest(
    id: 002,
    taskName: "Meeting with clients 2",
    taskDescription: "Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate.",
    taskTimeStart: "6:00 PM",
    taskTimeEnd: "8:00 PM",
    taskDate: "20 Mar, 2024",
    taskCategory: "home",
    priorityLevel: "low")
  static let thirdSampleTask = TaskNest(
    id: 003,
    taskName: "Meeting with clients 3",
    taskDescription: "Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate.",
    taskTimeStart: "6:00 PM",
    taskTimeEnd: "8:00 PM",
    taskDate: "21 Mar, 2024",
    taskCategory: "education",
    priorityLevel: "high")

  static let tasks = [
    firstSampleTask, secondSampleTask, thirdSampleTask,
    firstSampleTask, secondSampleTask, thirdSampleTask,
  ]
}
