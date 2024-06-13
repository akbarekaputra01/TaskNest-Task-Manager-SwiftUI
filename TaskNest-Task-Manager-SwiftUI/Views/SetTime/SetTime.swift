//
//  SetTime.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 11/06/24.
//

import SwiftUI

struct SetTime: View {
  @StateObject var viewModel = SetTimeViewModel()

  var body: some View {
    VStack {
      HStack {
        Text("Set Time")
          .frame(maxWidth: .infinity, alignment: .leading)
          .font(.title3)
          .fontWeight(.semibold)

        DatePicker(
          "",
          selection: $viewModel.selectedDate,
          displayedComponents: .date
        )
        .datePickerStyle(CompactDatePickerStyle())
      }

      HStack {
        ForEach(
          [
            viewModel.daySelectedMinTwo,
            viewModel.daySelectedMinOne,
            viewModel.daySelected,
            viewModel.daySelectedMinOne,
            viewModel.daySelectedMinTwo,
          ],
          id: \.self
        ) { day in
          Spacer()
          Text(day)
            .font(.body)
            .foregroundStyle(.gray)
            .frame(width: 40, height: 40)
          Spacer()
        }
      }

      HStack {
        ForEach(
          [
            viewModel.dateSelectedMinTwo,
            viewModel.dateSelectedMinOne,
            viewModel.dateSelected,
            viewModel.dateSelectedMinOne,
            viewModel.dateSelectedMinTwo,
          ], id: \.self
        ) { date in

          Spacer()
          if date == viewModel.formattedDateSelected {
            Circle()
              .fill(.accent)
              .frame(width: 40, height: 40)
              .overlay(
                Text("\(date)")
                  .font(.body)
                  .foregroundColor(.white)
              )
          } else {
            Text("\(date)")
              .font(.body)
              .frame(width: 40, height: 40)
          }
          Spacer()

        }
      }

      HStack {
        Button(action: {
          viewModel.isDatePickerStartShown.toggle()
        }) {
          HStack {
            Text("From")
            Spacer()
            Text(
              viewModel.formattedHourAndMinuteStart
            ).fontWeight(.bold)
            Spacer()
            Image(systemName: "chevron.down")
          }
          .padding()
          .cornerRadius(8)
          .overlay(
            RoundedRectangle(cornerRadius: 5)
              .stroke(Color.gray.opacity(0.5), lineWidth: 1)
          )
        }
        .sheet(isPresented: $viewModel.isDatePickerStartShown) {
          VStack {
            DatePicker(
              "From",
              selection: $viewModel.selectedDateStart,
              displayedComponents: .hourAndMinute
            )
            .labelsHidden()

            .padding()

            Button(
              action: {
                viewModel.isDatePickerStartShown.toggle()
              },
              label: {
                Text("Done")
              })
          }
          .presentationDetents([.medium])
        }

        Button(action: {
          viewModel.isDatePickerEndShown.toggle()
        }) {
          HStack {
            Text("To")
            Spacer()
            Text(
              viewModel.formattedHourAndMinuteEnd
            ).fontWeight(.bold)
            Spacer()
            Image(systemName: "chevron.down")
          }
          .padding()
          .cornerRadius(8)
          .overlay(
            RoundedRectangle(cornerRadius: 5)
              .stroke(Color.gray.opacity(0.5), lineWidth: 1)
          )
        }
        .sheet(isPresented: $viewModel.isDatePickerEndShown) {
          VStack {
            DatePicker(
              "To",
              selection: $viewModel.selectedDateEnd,
              displayedComponents: .hourAndMinute
            )
            .labelsHidden()

            .padding()

            Button(
              action: {
                viewModel.isDatePickerEndShown.toggle()
              },
              label: {
                Text("Done")
              })
          }
          .presentationDetents([.medium])
        }
      }
      .padding(.top, 8)
    }
    .padding(.horizontal, 2)

  }
}

#Preview{
  SetTime()
}
