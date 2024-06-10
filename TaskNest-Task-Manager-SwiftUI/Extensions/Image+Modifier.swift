//
//  Image+Modifier.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 10/06/24.
//

import SwiftUI

extension Image {
  func notificationButtonStyle() -> some View {
    self
      .padding(8)
      .background(Color.clear)
      .foregroundColor(.black)
      .clipShape(Circle())
      .overlay(
        RoundedRectangle(cornerRadius: 10)
          .stroke(Color.black.opacity(0.5), lineWidth: 0.5)
      )
  }
}

