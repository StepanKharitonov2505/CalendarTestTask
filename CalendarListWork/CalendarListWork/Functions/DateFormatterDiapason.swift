//
//  DateFormatter.swift
//  CalendarListWork
//
//  Created by Степан Харитонов on 23.11.2022.
//

import Foundation

class DateFormatterDiapason {
    static func dateFormatt(date: Date) -> [Date] {
        var arrayDiapasonDate: [Date] = []
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let selectDate = formatter.string(from: date)
        let arraySplitSelectDate = selectDate.components(separatedBy: "-")
        print(arraySplitSelectDate)
        let userCalendar = Calendar(identifier: .gregorian)
        var components1 = DateComponents()
        var components2 = DateComponents()
        components1.timeZone = TimeZone.autoupdatingCurrent
        components2.timeZone = components1.timeZone
        components1.day = Int(arraySplitSelectDate[0])
        components2.day = components1.day
        components1.month = Int(arraySplitSelectDate[1])
        components2.month = components1.month
        components1.year = Int(arraySplitSelectDate[2])
        components2.year = components1.year
        components1.hour = 4
        components2.hour = 28
        let startDate = userCalendar.date(from: components1)
        let endDate = userCalendar.date(from: components2)
        arrayDiapasonDate.append(startDate!)
        arrayDiapasonDate.append(endDate!)
        return arrayDiapasonDate
    }
}
