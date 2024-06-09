//
//  TaskNestTabView.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 09/06/24.
//

import SwiftUI

struct TaskNestTabView: View {
  @State private var isWelcome: Bool = true

  var body: some View {
    TabView {
      HomeScreen()
        .tabItem { Label("Home", systemImage: "house") }
      CreateTaskScreen()
        .tabItem { Label("Create Task", systemImage: "plus") }
      CalendarScreen()
        .tabItem { Label("Calendar", systemImage: "calendar") }
      AccountScreen()
        .tabItem { Label("Account", systemImage: "person") }

    }
  }
}

#Preview{
  TaskNestTabView()
}
