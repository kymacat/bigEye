//
//  GroupVCModel.swift
//  Big eye
//
//  Created by Const. on 30.06.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

protocol IGroupVCModel {
    func savePerson(person: GroupMemberModel)
    func fetchGroupMembers() -> [GroupMemberModel]
}

class GroupVCModel: IGroupVCModel {
    
    private let groupService: IGroupService
    
    init(service: IGroupService) {
        groupService = service
    }
    
    func savePerson(person: GroupMemberModel) {
        groupService.savePerson(person: person)
    }
    
    func fetchGroupMembers() -> [GroupMemberModel] {
        return groupService.fetchPersons()
    }
}
