//
//  ServicesAssembly.swift
//  Big eye
//
//  Created by Const. on 30.06.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

protocol IServicesAssembly {
    var groupService: IGroupService { get }
    var timetableService: ITimetableService { get }
}

class ServicesAssembly: IServicesAssembly {
    
    private let coreAssembly: ICoreAssembly
    
    init(coreAssembly: ICoreAssembly) {
        self.coreAssembly = coreAssembly
    }
    
    lazy var groupService: IGroupService = GroupService(dataManager: coreAssembly.groupFileManager)
    
    lazy var timetableService: ITimetableService = TimetableService(dataManager: coreAssembly.timetableFileManager)
}
