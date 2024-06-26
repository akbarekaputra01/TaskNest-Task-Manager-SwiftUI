//
//  ContentView.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 09/06/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isWelcome: Bool = true

    var body: some View {
        ZStack {
            if isWelcome {
                WelcomeView(isWelcome: $isWelcome)
            } else {
                TaskNestTabView()
            }
        }
    }
}

#Preview {
    ContentView()
}
