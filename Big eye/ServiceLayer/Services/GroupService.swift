//
//  GroupService.swift
//  Big eye
//
//  Created by Const. on 03.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

protocol IGroupService {
    func savePerson(firstName: String, lastName: String, info: String?, image: UIImage?)
}

class GroupService: IGroupService {

    private let dataManager: IGroupFileManager
    
    init(dataManager: IGroupFileManager) {
        self.dataManager = dataManager
    }
    
    func savePerson(firstName: String, lastName: String, info: String?, image: UIImage?) {
        let imageData = image?.pngData()
        dataManager.savePerson(firstName: firstName, lastName: lastName, info: info, image: imageData)
    }
    
}
