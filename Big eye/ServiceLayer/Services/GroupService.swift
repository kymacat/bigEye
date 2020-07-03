//
//  GroupService.swift
//  Big eye
//
//  Created by Const. on 03.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

protocol IGroupService {
    func savePerson(person: GroupMemberModel)
    func fetchPersons() -> [GroupMemberModel]
}

class GroupService: IGroupService {

    private let dataManager: IGroupFileManager
    
    init(dataManager: IGroupFileManager) {
        self.dataManager = dataManager
    }
    
    func savePerson(person: GroupMemberModel) {
        let imageData = person.image?.pngData()
        dataManager.savePerson(firstName: person.firstName, lastName: person.lastName, info: person.description, image: imageData)
    }
    
    func fetchPersons() -> [GroupMemberModel] {
        var persons = [GroupMemberModel]()
        
        let fechedPersons = dataManager.fetchPersons()
        
        for person in fechedPersons {
            var image: UIImage? = nil
            if let data = person.image {
                image = UIImage(data: data)
            }
            let newPerson = GroupMemberModel(image: image, firstName: person.firstName, lastName: person.lastName, description: person.info)
            persons.append(newPerson)
        }
        
        let sortedPersons = persons.sorted { (first, second) -> Bool in
            if first.lastName < second.lastName {
                return true
            }
            return false
        }
        
        return sortedPersons
    }
    
}
