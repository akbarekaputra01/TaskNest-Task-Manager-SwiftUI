//
//  TaskNestTabView.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 09/06/24.
//

import SwiftUI

struct TaskNestTabView: View {
  var body: some View {
    TabView {
      SignUpView()
        .tabItem { Label("Home", systemImage: "house") }
      TasksView()
        .tabItem { Label("Tasks", systemImage: "list.clipboard") }
      CalendarView()
        .tabItem { Label("Calendar", systemImage: "calendar") }
      AccountView()
        .tabItem { Label("Account", systemImage: "person") }
    }
  }
}

#Preview{
  TaskNestTabView()
}
