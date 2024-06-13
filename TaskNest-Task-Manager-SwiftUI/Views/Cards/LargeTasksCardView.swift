//
//  LargeTasksCardView.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 10/06/24.
//

import SwiftUI

struct LargeTasksCardView: View {
  var tasks: TaskNest

  var body: some View {
    HStack {
      Image(
        systemName: tasks.taskCategory == "Work"
          ? "handbag.fill"
          : tasks.taskCategory == "Home"
            ? "house.fill"
            : tasks.taskCategory == "Finance"
              ? "dollarsign"
              : tasks.taskCategory == "Education"
                ? "book.fill"
                : tasks.taskCategory == "Health"
                  ? "figure.disc.sports"
                  : "camera.metering.unknown"
      )
      .resizable()
      .frame(width: 20, height: 20)
      .padding(20)
      .background(.gray.opacity(0.1))
      .cornerRadius(12)

      VStack(alignment: .leading, spacing: 3) {
        Text(tasks.taskTitle)
          .fontWeight(.bold)
        Text(tasks.taskDescription)
          .foregroundColor(.isDark.opacity(0.5))
          .font(.system(size: 14))
        Text("\(tasks.taskTimeStart) - \(tasks.taskTimeEnd)")
          .foregroundColor(.accent)
          .fontWeight(.semibold)
          .font(.system(size: 14))
      }
      .padding(.leading, 5)
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: 105)
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(color: Color.gray.opacity(0.5), radius: 5)
  }
}

#Preview{
  LargeTasksCardView(
    tasks: MockData.sampleTaskTwo)
}
