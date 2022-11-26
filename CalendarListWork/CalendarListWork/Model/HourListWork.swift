//
//  File.swift
//  CalendarListWork
//
//  Created by Степан Харитонов on 22.11.2022.
//

import Foundation

struct HourListWork {
    let startTimeHour: Int
    let finalTimeHour: Int
}

class CellsStaticContentInitialize {
    static func cellsStaticTimeInfo() -> [HourListWork] {
        let containerTimeIntervals = {
            var v: [HourListWork] = []
            var startTimeHour = 0
            while startTimeHour <= 23 {
                let timeSplitElement = HourListWork(startTimeHour: startTimeHour, finalTimeHour: startTimeHour+1)
                startTimeHour += 1
                v.append(timeSplitElement)
            }
            return v
        }()
        return containerTimeIntervals
    }
}
