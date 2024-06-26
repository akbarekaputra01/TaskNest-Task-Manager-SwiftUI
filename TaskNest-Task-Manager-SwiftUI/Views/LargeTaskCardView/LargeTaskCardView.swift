//
//  LargeTaskCardView.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 10/06/24.
//

import SwiftUI

struct LargeTaskCardView: View {
    @ObservedObject var viewModel: LargeTaskCardViewModel

    var body: some View {
        HStack {
            Image(
                systemName: viewModel.categoryImageSystemName
            )
            .resizable()
            .frame(width: 20, height: 20)
            .padding(20)
            .background(.gray.opacity(0.1))
            .cornerRadius(12)

            VStack(alignment: .leading, spacing: 3) {
                Text(viewModel.taskTitle)
                    .fontWeight(.bold)
                Text(viewModel.taskDescription)
                    .foregroundColor(.isDark.opacity(0.5))
                    .font(.system(size: 14))
                Text(viewModel.formattedTaskTime)
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

#Preview {
    LargeTaskCardView(
        viewModel: LargeTaskCardViewModel(task: MockData.sampleTaskTwo))
}
