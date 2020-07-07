//
//  StatisticsService.swift
//  Big eye
//
//  Created by Const. on 08.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

protocol IStatisticsService {
    func fetchStatistics() -> [StatisticsModel]
}

class StatisticsService: IStatisticsService {
    let fileManager: IStatisticsFileManager
    
    init(fileManager: IStatisticsFileManager) {
        self.fileManager = fileManager
    }
    
    func fetchStatistics() -> [StatisticsModel] {
        let stat = fileManager.fetchStatistics()
        
        var models = [StatisticsModel]()
        
        for cell in stat {
            guard let marks = cell.attendenceMarks.allObjects as? [AttendanceMark] else {
                continue
            }
            
            var newMarks = [AttendanceModel]()
            
            for mark in marks {
                let newMark = AttendanceModel(isAttended: mark.mark, person: GroupMemberModel(image: nil, firstName: mark.firstName, lastName: mark.lastName, description: nil))
                newMarks.append(newMark)
            }
            
            let newModel = StatisticsModel(date: cell.date, teacher: cell.teacher, subject: cell.subject, marks: newMarks)
            
            models.append(newModel)
        }
        
        return models
    }
}
