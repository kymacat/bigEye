//
//  GroupVCModel.swift
//  Big eye
//
//  Created by Const. on 30.06.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

protocol IGroupVCModel {
    func savePerson(person: GroupMemberCellModel)
}

class GroupVCModel: IGroupVCModel {
    
    private let groupService: IGroupService
    
    init(service: IGroupService) {
        groupService = service
    }
    
    func savePerson(person: GroupMemberCellModel) {
        groupService.savePerson(firstName: person.firstName, lastName: person.lastName, info: person.description, image: person.image)
    }
}
