//
//  TimetableVCModel.swift
//  Big eye
//
//  Created by Const. on 04.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation


protocol ITimetableVCModel {
    func saveCell(cell: TimetableModel)
    func fetchCells() -> [TimetableModel]
}

class TimetableVCModel: ITimetableVCModel {
    
    private let timetableService: ITimetableService
    
    init(service: ITimetableService) {
        timetableService = service
    }
    
    func saveCell(cell: TimetableModel) {
        timetableService.saveCell(cell: cell)
    }
    
    func fetchCells() -> [TimetableModel] {
        return timetableService.fetchTimetable()
    }
    
}
