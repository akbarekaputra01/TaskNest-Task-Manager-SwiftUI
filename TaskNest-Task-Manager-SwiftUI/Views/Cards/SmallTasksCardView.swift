//
//  SmallTasksCardView.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 10/06/24.
//

import SwiftUI

struct SmallTasksCardView: View {
  var tasks: TaskNest

  // color scheme of device for using second way
  //  @Environment(\.colorScheme) var colorScheme

  var body: some View {
    VStack(alignment: .leading) {
      Button(action: {
        print("clicked")
      }) {
        Image(
          systemName:
            tasks.taskCategory == "Work"
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
        .scaledToFit()
        .frame(width: 40, height: 40)
        .padding(8)
        .background(Color.clear)

        // first way
        //          .foregroundColor(
        //            Color(
        //              UIColor { traitCollection in
        //                return traitCollection.userInterfaceStyle == .dark ? .white : .black
        //              })
        //          )

        // sec way
        //          .foregroundColor(colorScheme == .dark ? .white : .black)

        // third way
        .foregroundColor(.isDark)

        .overlay(
          RoundedRectangle(cornerRadius: 5)
            .stroke(Color.black.opacity(0.5), lineWidth: 0.5)
        )
      }

      Text(tasks.taskTitle)
        .font(.system(size: 18))
        .fontWeight(.semibold)
        .padding(.vertical, 1)

      Text("\(tasks.taskDate) at \(tasks.taskTimeStart)")
        .font(.system(size: 14))
        .foregroundColor(.isDark.opacity(0.5))

      Spacer()

      Button(
        action: {
          print("tapped")
        },
        label: {
          HStack {
            Text("View details")
              .font(.system(size: 14))
              .fontWeight(.semibold)
            Image(systemName: "arrow.right")
          }
        })
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding()
    .frame(width: 240, height: 160)
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(color: Color.gray.opacity(0.5), radius: 3, x: 3, y: 3)
    .padding(.leading)
  }
}
#Preview{
  SmallTasksCardView(tasks: MockData.sampleTaskOne)
}
