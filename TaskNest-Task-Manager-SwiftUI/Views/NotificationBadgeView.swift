//
//  NotificationBadgeView.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 10/06/24.
//

import SwiftUI

struct NotifBadgeModifier: ViewModifier {
  var count: Int

  func body(content: Content) -> some View {
    ZStack(alignment: .topTrailing) {
      content
      if count > 0 {
        Text("\(count)")
          .font(.caption)
          .foregroundColor(.white)
          .padding(4)
          .background(Color.red)
          .clipShape(Circle())
          .offset(x: 6, y: -6)
      }
    }
  }
}

#Preview{
  Image(systemName: "bell")
    .modifier(NotifBadgeModifier(count: 7))
}
