//
//  DateUtils.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 11/06/24.
//

import Foundation

class DateUtils {
  static func formattedDDMMYYYY(selectedDate: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM, yyyy"
    return formatter.string(from: selectedDate)
  }

  static func formattedDay(selectedDate: Date, offset: Int = 0) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEE"
    if let date = Calendar.current.date(byAdding: .day, value: offset, to: selectedDate) {
      return formatter.string(from: date)
    } else {
      return "Some error occurred"
    }
  }

  static func formattedDate(selectedDate: Date, offset: Int = 0) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "d"
    if let date = Calendar.current.date(byAdding: .day, value: offset, to: selectedDate) {
      return formatter.string(from: date)
    } else {
      return "Some error occurred"
    }
  }

  static func formattedMonth(selectedDate: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM"
    return formatter.string(from: selectedDate)
  }

  static func formattedYear(selectedDate: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    return formatter.string(from: selectedDate)
  }

  static func formattedHour(selectedDate: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH"
    return formatter.string(from: selectedDate)
  }

  static func formattedMinute(selectedDate: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "mm"
    return formatter.string(from: selectedDate)
  }
}
