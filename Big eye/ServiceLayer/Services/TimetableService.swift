//
//  TimetableService.swift
//  Big eye
//
//  Created by Const. on 07.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

protocol ITimetableService {
    func saveCell(cell: TimetableModel)
    func fetchTimetable() -> [TimetableModel]
}

class TimetableService: ITimetableService {
    
    private let dataManager: ITimetableFileManager
    
    init(dataManager: ITimetableFileManager) {
        self.dataManager = dataManager
    }
    
    func saveCell(cell: TimetableModel) {
        
        dataManager.saveCell(name: cell.name, rows: cell.subjects)
    }
    
    func fetchTimetable() -> [TimetableModel] {
        
        var currTimetable = [TimetableModel]()
        let fechedTimetable = dataManager.fetchTimetable()
        
        for cell in fechedTimetable {
            guard let rows = cell.rows.allObjects as? [SheduleRow] else {
                continue
            }
            
            var newRows = [TimetableRowModel]()
            for row in rows {
                let newRow = TimetableRowModel(startTime: row.startTime, endTime: row.endTime, teacher: row.teacher, subjectNeme: row.subject)
                newRows.append(newRow)
            }
            
            let sortedRows = newRows.sorted { (first, second) -> Bool in
                if first.startTime < second.startTime {
                    return true
                }
                return false
            }
            
            let newCell = TimetableModel(name: cell.name, subjects: sortedRows)
            
            currTimetable.append(newCell)
        }
        
        return currTimetable
    }
    
}
