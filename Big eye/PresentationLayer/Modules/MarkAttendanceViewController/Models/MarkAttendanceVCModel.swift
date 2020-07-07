//
//  MarkAttendanceVCModel.swift
//  Big eye
//
//  Created by Const. on 07.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

protocol IMarkAttendanceVCModel {
    func saveStatistics(date: Date, teacher: String, subject: String, stat: [AttendanceModel])
    func fetchData() -> [AttendanceModel]
}

class MarkAttendanceVCModel: IMarkAttendanceVCModel {
    
    private let service: IMarkAttendanceService
    
    init(service: IMarkAttendanceService) {
        self.service = service
    }

    func fetchData() -> [AttendanceModel] {
        return service.fetchGroupMembers()
    }
    
    func saveStatistics(date: Date, teacher: String, subject: String, stat: [AttendanceModel]) {
        service.saveReport(date: date, teacher: teacher, subject: subject, stat: stat)
    }
}
