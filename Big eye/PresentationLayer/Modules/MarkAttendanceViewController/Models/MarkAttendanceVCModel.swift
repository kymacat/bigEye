//
//  MarkAttendanceVCModel.swift
//  Big eye
//
//  Created by Const. on 07.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

protocol IMarkAttendanceVCModel {
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
}
