//
//  SmallTaskCardView.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 13/06/24.
//

import SwiftUI

struct SmallTaskCardView: View {
    @ObservedObject var viewModel: SmallTaskCardViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                print("Category button clicked")
            }) {
                Image(systemName: viewModel.categoryImageSystemName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(8)
                    .foregroundColor(.isDark)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black.opacity(0.5), lineWidth: 0.5)
                    )
            }

            Text(viewModel.taskTitle)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .padding(.vertical, 1)

            Text(viewModel.formattedDateAndTime)
                .font(.system(size: 14))
                .foregroundColor(.isDark.opacity(0.5))

            Spacer()

            Button(action: {
                viewModel.onViewDetailsTapped()
            }) {
                HStack {
                    Text("View details")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
            }
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

#Preview {
    SmallTaskCardView(viewModel: SmallTaskCardViewModel(task: MockData.sampleTaskOne))
}
