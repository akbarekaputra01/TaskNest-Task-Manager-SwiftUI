//
//  CreateTaskScreen.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 09/06/24.
//

import SwiftUI

struct CreateTaskScreen: View {
  // to close this screen
  @Environment(\.presentationMode) var presentationMode

  @State private var taskTitle: String = ""
  @State private var taskDescription: String = ""
  @State private var selectedPriority: String?

  @FocusState private var focusedTextField: FormTextField?
  enum FormTextField {
    case taskTitle, taskDescription
  }

  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        Text("Task Detail")
          .frame(maxWidth: .infinity, alignment: .leading)
          .font(.title3)
          .fontWeight(.semibold)

        TextField("Task Title", text: $taskTitle)
          .padding()
          .background(Color.gray.opacity(0.05))
          .overlay(
            RoundedRectangle(cornerRadius: 5)
              .stroke(Color.gray.opacity(0.5), lineWidth: 1)
          )
          .focused($focusedTextField, equals: .taskTitle)
          .onSubmit { focusedTextField = .taskDescription }
          .submitLabel(.next)
          .padding(.bottom, 8)

        ZStack(alignment: .leading) {
          if taskDescription.isEmpty {
            VStack {
              Text("Task Description")
                .foregroundColor(.gray.opacity(0.75))
              Spacer()
            }
            .padding()
          }
          VStack {
            TextEditor(text: $taskDescription)
              .opacity(taskDescription.isEmpty ? 0.25 : 0.5)
              .focused($focusedTextField, equals: .taskDescription)
              .onSubmit { focusedTextField = .taskTitle }
              .submitLabel(.next)
            Spacer()
          }
          .padding(.leading, 10)
          .padding(.top, 8)
        }
        .frame(height: 100, alignment: .leading)
        .background(Color.gray.opacity(0.05))
        .overlay(
          RoundedRectangle(cornerRadius: 5)
            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )

        SetTimeView()
          .padding(.top)

        Text("Select Priority")
          .frame(maxWidth: .infinity, alignment: .leading)
          .font(.title3)
          .fontWeight(.semibold)
          .padding(.top)

        HStack {
          Button(action: {
            selectedPriority = "High"
          }) {
            Text("High")
              .foregroundColor(selectedPriority == "High" ? .accent : .gray)
              .frame(maxWidth: .infinity)
              .padding(12)
              .cornerRadius(10)
              .overlay(
                RoundedRectangle(cornerRadius: 10)
                  .stroke(
                    selectedPriority == "High" ? .accent : .gray,
                    lineWidth: 1)
              )
          }
          .frame(width: 112)

          Spacer()

          Button(action: {
            selectedPriority = "Medium"
          }) {
            Text("Medium")
              .foregroundColor(selectedPriority == "Medium" ? .accent : .gray)
              .frame(maxWidth: .infinity)
              .padding(12)
              .cornerRadius(10)
              .overlay(
                RoundedRectangle(cornerRadius: 10)
                  .stroke(
                    selectedPriority == "Medium" ? .accent : .gray,
                    lineWidth: 1)
              )
          }
          .frame(width: 112)

          Spacer()

          Button(action: {
            selectedPriority = "Low"
          }) {
            Text("Low")
              .foregroundColor(selectedPriority == "Low" ? .accent : .gray)
              .frame(maxWidth: .infinity)
              .padding(12)
              .cornerRadius(10)
              .overlay(
                RoundedRectangle(cornerRadius: 10)
                  .stroke(
                    selectedPriority == "Low" ? .accent : .gray,
                    lineWidth: 1)
              )
          }
          .frame(width: 112)
        }
        .padding(.horizontal, 2)

        Button(action: {
          // action
        }) {
          Text("Add Task")
            .foregroundColor(.white)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding(12)
            .background(.accent)
            .cornerRadius(10)
        }
        .padding(.top)

      }

      .padding()
      .navigationBarTitle("Create Task", displayMode: .inline)
      .navigationBarItems(
        leading:
          Button(action: {
            // to close this screen
            presentationMode.wrappedValue.dismiss()
          }) {
            Image(systemName: "chevron.backward")
              .resizable()
              .scaledToFit()
              .frame(height: 20)
              .foregroundColor(Color.primary)
              .padding(.vertical)
          }
      )
    }
  }
}

struct CreateTaskScreen_Previews: PreviewProvider {
  static var previews: some View {
    CreateTaskScreen()
  }
}