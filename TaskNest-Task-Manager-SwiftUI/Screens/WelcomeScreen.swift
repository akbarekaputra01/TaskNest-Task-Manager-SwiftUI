//
//  WelcomeScreen.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 09/06/24.
//

import SwiftUI

struct WelcomeScreen: View {
  @Binding var isWelcome: Bool

  var body: some View {
    VStack {
      Spacer()

      Image("PeopleWriting")
        .resizable()
        .scaledToFit()
        .frame(width: 200)

      Spacer()

      VStack {
        Text("Effortlessly Organise Your Day")
          .fontWeight(.bold)
          .font(.system(size: 32))
          .multilineTextAlignment(.center)
          .padding(.bottom)

        Text("Borem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate.")
          .font(.system(size: 16))
          .multilineTextAlignment(.center)
          .foregroundColor(Color.isDark.opacity(0.5))
      }
      .padding(.horizontal, 28)

      Spacer()

      Button(action: {
        self.isWelcome = false
      }) {
        Text("Next")
          .font(.headline)
          .foregroundColor(.white)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.colorBrandPrimary)
          .cornerRadius(8)
      }
    }
    .padding()
  }
}

#Preview{
  WelcomeScreen(isWelcome: .constant(true))
}
