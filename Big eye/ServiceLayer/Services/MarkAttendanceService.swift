//
//  MarkAttendanceService.swift
//  Big eye
//
//  Created by Const. on 07.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

protocol IMarkAttendanceService {
    func fetchGroupMembers() -> [AttendanceModel]
}

class MarkAttendanceService: IMarkAttendanceService {
    
    private let groupDataManager: IGroupFileManager
    
    init(groupDataManager: IGroupFileManager) {
        self.groupDataManager = groupDataManager
    }
    
    func fetchGroupMembers() -> [AttendanceModel] {
        
        var models = [AttendanceModel]()
        
        let fechedPersons = groupDataManager.fetchPersons()
        
        for person in fechedPersons {
            let newPerson = GroupMemberModel(image: nil, firstName: person.firstName, lastName: person.lastName, description: person.info)
            let newModel = AttendanceModel(isAttended: false, person: newPerson)
            
            models.append(newModel)
        }
        
        let sortedModel = models.sorted { (first, second) -> Bool in
            if first.person.lastName < second.person.lastName {
                return true
            }
            return false
        }
        
        return sortedModel
        
    }
    
}
