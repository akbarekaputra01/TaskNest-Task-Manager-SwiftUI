//
//  TodaysTasksCardView.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 10/06/24.
//

import SwiftUI

struct TodaysTasksCardView: View {
  var taskCategory: String
  var taskTitle: String
  var taskDescription: String
  var taskTime: String

  var body: some View {
    VStack {
      HStack {
        Image(
          systemName: taskCategory == "work"
            ? "handbag.fill"
            : taskCategory == "home"
              ? "house.fill"
              : taskCategory == "finance"
                ? "dollarsign"
                : taskCategory == "education"
                  ? "book.fill"
                  : taskCategory == "health"
                    ? "figure.disc.sports"
                    : "camera.metering.unknown"
        )
        .resizable()
        .frame(width: 25, height: 25)
        .scaledToFit()
        .padding(20)
        .background(.gray.opacity(0.1))
        .cornerRadius(12)
        VStack(alignment: .leading, spacing: 3) {
          Text(taskTitle)
            .fontWeight(.bold)
          Text(taskDescription)
            .foregroundColor(.isDark.opacity(0.5))
            .font(.system(size: 14))
          Text(taskTime)
            .foregroundColor(.accent)
            .fontWeight(.semibold)
            .font(.system(size: 14))
        }
      }
      .padding()
    }
    .frame(maxWidth: .infinity, maxHeight: 103)
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(color: Color.gray.opacity(0.5), radius: 5)
  }
}

#Preview{
  TodaysTasksCardView(
    taskCategory: "work",
    taskTitle: "Preparations",
    taskDescription: "Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate.",
    taskTime: "7:30 AM - 8:00 AM")
}
