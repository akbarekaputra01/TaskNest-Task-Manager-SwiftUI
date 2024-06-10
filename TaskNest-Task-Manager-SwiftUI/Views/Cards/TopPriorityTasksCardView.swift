//
//  TopPriorityTasksCardView.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 10/06/24.
//

import SwiftUI

struct TopPriorityTasksCardView: View {
  // color scheme of device for using second way
  //  @Environment(\.colorScheme) var colorScheme

  var category: String
  var task: String
  var time: String

  var body: some View {
    ZStack {
      VStack(alignment: .leading) {
        Spacer()
        Button(action: {
          print("clicked")
        }) {
          Image(
            systemName:
              category == "work"
              ? "handbag.fill"
              : category == "home"
                ? "house.fill"
                : category == "finance"
                  ? "dollarsign"
                  : category == "education"
                    ? "book.fill"
                    : category == "health"
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

          .clipShape(Circle())
          .overlay(
            RoundedRectangle(cornerRadius: 5)
              .stroke(Color.black.opacity(0.5), lineWidth: 0.5)
          )
        }

        Text(task)
          .font(.system(size: 18))
          .fontWeight(.semibold)
          .padding(.vertical, 1)

        Text(time)
          .font(.system(size: 12))
          .foregroundColor(.isDark.opacity(0.5))

        Spacer()
        Button(
          action: {
            print("tapped")
          },
          label: {
            HStack {
              Text("View details")
                .font(.system(size: 12))
                .fontWeight(.semibold)
              Image(systemName: "arrow.right")
            }
          })
        Spacer()
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding()
    .frame(width: 240, height: 160)
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 3, y: 3)
    .padding(.leading)
  }
}

#Preview{
  TopPriorityTasksCardView(
    category: "work", task: "Meeting with clients", time: "19 Mar, 2024 at 7:30 PM")
}
