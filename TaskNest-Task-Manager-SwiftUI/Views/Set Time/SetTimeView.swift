//
//  SetTimeView.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 11/06/24.
//

import SwiftUI

struct SetTimeView: View {
  @State private var selectedDate = Date()
  @State private var fromSelectedDate = Date()
  @State private var toSelectedDate = Date()

  @State private var isFromDatePickerShown = false
  @State private var isToDatePickerShown = false

  var body: some View {
    VStack {
      HStack {
        Text("Set Time")
          .frame(maxWidth: .infinity, alignment: .leading)
          .font(.title3)
          .fontWeight(.semibold)

        DatePicker(
          "",
          selection: $selectedDate,
          displayedComponents: .date
        )
        .datePickerStyle(CompactDatePickerStyle())
      }

      HStack {
        ForEach(
          [
            DateUtils.formattedDay(selectedDate: selectedDate, offset: -2),
            DateUtils.formattedDay(selectedDate: selectedDate, offset: -1),
            DateUtils.formattedDay(selectedDate: selectedDate),
            DateUtils.formattedDay(selectedDate: selectedDate, offset: 1),
            DateUtils.formattedDay(selectedDate: selectedDate, offset: 2),
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
            DateUtils.formattedDate(selectedDate: selectedDate, offset: -2),
            DateUtils.formattedDate(selectedDate: selectedDate, offset: -1),
            DateUtils.formattedDate(selectedDate: selectedDate),
            DateUtils.formattedDate(selectedDate: selectedDate, offset: 1),
            DateUtils.formattedDate(selectedDate: selectedDate, offset: 2),
          ], id: \.self
        ) { day in
          Spacer()
          if day == "\(DateUtils.formattedDate(selectedDate: selectedDate))" {
            Circle()
              .fill(.accent)
              .frame(width: 40, height: 40)
              .overlay(
                Text("\(day)")
                  .font(.body)
                  .foregroundColor(.white)
              )
          } else {
            Text("\(day)")
              .font(.body)
              .frame(width: 40, height: 40)
          }
          Spacer()
        }
      }

      HStack {
        Button(action: {
          isFromDatePickerShown.toggle()
        }) {
          HStack {
            Text("From")
            Spacer()
            Text(
              "\(DateUtils.formattedHour(selectedDate: fromSelectedDate)):\(DateUtils.formattedMinute(selectedDate: fromSelectedDate))"
            )
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
        .sheet(isPresented: $isFromDatePickerShown) {
          VStack {
            DatePicker(
              "From",
              selection: $fromSelectedDate,
              displayedComponents: .hourAndMinute
            )
            .labelsHidden()

            .padding()

            Button(
              action: {
                isFromDatePickerShown.toggle()
              },
              label: {
                Text("Done")
              })
          }
          .presentationDetents([.medium])
        }

        Button(action: {
          isToDatePickerShown.toggle()
        }) {
          HStack {
            Text("To")
            Spacer()
            Text(
              "\(DateUtils.formattedHour(selectedDate: toSelectedDate)):\(DateUtils.formattedMinute(selectedDate: toSelectedDate))"
            )
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
        .sheet(isPresented: $isToDatePickerShown) {
          VStack {
            DatePicker(
              "To",
              selection: $toSelectedDate,
              displayedComponents: .hourAndMinute
            )
            .labelsHidden()

            .padding()

            Button(
              action: {
                isToDatePickerShown.toggle()
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
  SetTimeView()
}
