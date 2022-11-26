//
//  ArraySplitDate.swift
//  CalendarListWork
//
//  Created by Степан Харитонов on 23.11.2022.
//

import Foundation

class ArraySplitDate {
    static func arraySplitDate(work: Work) -> [String] {
        var array: [String] = []
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let selectStartDate = formatter.string(from: work.startTime)
        let arraySplitStartDate = selectStartDate.components(separatedBy: ":")
        let selectFinalDate = formatter.string(from: work.finalTime)
        let arraySplitFinalDate = selectFinalDate.components(separatedBy: ":")
        let startDate = arraySplitStartDate[0]
        let finalDate = arraySplitFinalDate[0]
        array.append(startDate)
        array.append(finalDate)
        return array
    }
}
