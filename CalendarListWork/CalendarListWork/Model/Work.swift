//
//  StructureWork.swift
//  CalendarListWork
//
//  Created by Степан Харитонов on 19.11.2022.
//

import Foundation
import RealmSwift

class Work: Object {
    @Persisted var startTime: Date
    @Persisted var finalTime: Date
    @Persisted var nameWork: String
    @Persisted var descriptionWork: String

    convenience init(
        startTime: Date,
        finalTime: Date,
        nameWork: String,
        descriptionWork: String
    ) {
            self.init()
            self.startTime = startTime
            self.finalTime = finalTime
            self.nameWork = nameWork
            self.descriptionWork = descriptionWork
    }
    
    
}
