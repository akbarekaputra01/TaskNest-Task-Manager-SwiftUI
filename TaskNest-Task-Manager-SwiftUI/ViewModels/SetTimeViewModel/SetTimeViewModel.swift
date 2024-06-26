//
//  SetTimeViewModel.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 13/06/24.
//

import SwiftUI

final class SetTimeViewModel: ObservableObject {
    @Published var selectedDate: Date = .init() {
        // The didSet used to automatically call the update functions whenever selectedDate changes.
        didSet {
            self.updateDateStrings()
            self.updateDayStrings()
            self.formattingDateSelected()
        }
    }

    @Published var selectedDateStart: Date = .init()
    @Published var selectedDateEnd: Date = .init()

    @Published var isDatePickerStartShown: Bool = false
    @Published var isDatePickerEndShown: Bool = false

    @Published var dateSelectedMinTwo: String = ""
    @Published var dateSelectedMinOne: String = ""
    @Published var dateSelected: String = ""
    @Published var dateSelectedPlusOne: String = ""
    @Published var dateSelectedPlusTwo: String = ""

    @Published var daySelectedMinTwo: String = ""
    @Published var daySelectedMinOne: String = ""
    @Published var daySelected: String = ""
    @Published var daySelectedPlusOne: String = ""
    @Published var daySelectedPlusTwo: String = ""

    @Published var formattedDateSelected: String = ""

    init() {
        self.updateDateStrings()
        self.updateDayStrings()
        self.formattingDateSelected()
    }

    private func updateDateStrings() {
        self.dateSelectedMinTwo = DateUtils.formattedDate(selectedDate: self.selectedDate, offset: -2)
        self.dateSelectedMinOne = DateUtils.formattedDate(selectedDate: self.selectedDate, offset: -1)
        self.dateSelected = DateUtils.formattedDate(selectedDate: self.selectedDate)
        self.dateSelectedPlusOne = DateUtils.formattedDate(selectedDate: self.selectedDate, offset: 1)
        self.dateSelectedPlusTwo = DateUtils.formattedDate(selectedDate: self.selectedDate, offset: 2)
    }

    private func updateDayStrings() {
        self.daySelectedMinTwo = DateUtils.formattedDay(selectedDate: self.selectedDate, offset: -2)
        self.daySelectedMinOne = DateUtils.formattedDay(selectedDate: self.selectedDate, offset: -1)
        self.daySelected = DateUtils.formattedDay(selectedDate: self.selectedDate)
        self.daySelectedPlusOne = DateUtils.formattedDay(selectedDate: self.selectedDate, offset: 1)
        self.daySelectedPlusTwo = DateUtils.formattedDay(selectedDate: self.selectedDate, offset: 2)
    }

    private func formattingDateSelected() {
        self.formattedDateSelected = DateUtils.formattedDate(selectedDate: self.selectedDate)
    }

    var formattedHourAndMinuteStart: String {
        return
            "\(DateUtils.formattedHour(selectedDate: self.selectedDateStart)):\(DateUtils.formattedMinute(selectedDate: self.selectedDateStart))"
    }

    var formattedHourAndMinuteEnd: String {
        return
            "\(DateUtils.formattedHour(selectedDate: self.selectedDateEnd)):\(DateUtils.formattedMinute(selectedDate: self.selectedDateEnd))"
    }

    func updateDateFromMyCalendarClicked(date: String) {
        let result = Int(date)! - Int(self.formattedDateSelected)!

        if let updateSelectedDate = Calendar.current.date(
            byAdding: .day, value: result, to: selectedDate)
        {
            self.selectedDate = updateSelectedDate
        } else {
            print("Fail update selected date")
        }
    }
}
