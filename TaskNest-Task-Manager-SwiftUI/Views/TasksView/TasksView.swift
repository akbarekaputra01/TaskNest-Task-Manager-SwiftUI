//
//  TasksView.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 10/06/24.
//

import SwiftUI

struct TasksView: View {
    @StateObject var viewModel = TasksViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.allTasks.isEmpty {
                    Spacer()
                    Text("No tasks found")
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 22) {
                            ForEach(viewModel.allTasks, id: \.id) { task in
                                LargeTaskCardView(viewModel: LargeTaskCardViewModel(task: task))
                            }
                        }
                        .padding()
                    }
                }
            }

            .navigationBarTitle("Tasks", displayMode: .inline)
            .navigationBarItems(
                trailing:
                Button(
                    action: {
                        viewModel.isShowingCreateTaskScreen.toggle()
                    },
                    label: {
                        Image(systemName: "plus.app")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                            .foregroundColor(.isDark)
                    }))
        }
        .fullScreenCover(
            isPresented: $viewModel.isShowingCreateTaskScreen,
            content: {
                CreateTaskView()
            })
    }
}

#Preview {
    TasksView()
}
