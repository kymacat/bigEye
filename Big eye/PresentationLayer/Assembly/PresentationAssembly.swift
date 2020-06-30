//
//  PresentationAssembly.swift
//  Big eye
//
//  Created by Const. on 30.06.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

protocol IPresentationAssembly {
    func eyeTabBarController() -> EyeTabBarController
    func groupViewController() -> GroupViewController
}

class PresentationAssembly: IPresentationAssembly {
    
    private let serviceAssembly: IServicesAssembly
    
    init(serviceAssembly: IServicesAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    // MARK: - EyeTabBarController
    
    func eyeTabBarController() -> EyeTabBarController {
        let controller = EyeTabBarController()
        
        let groupItem = EyeTabBarItem(iconName: "group", title: "Группа")
        let timetableItem = EyeTabBarItem(iconName: "calendar", title: "Расписание")
        let statisticsItem = EyeTabBarItem(iconName: "stat", title: "Статистика")

        
        controller.setTabBar(items: [groupItem, timetableItem, statisticsItem])
        controller.viewControllers = [groupViewController(), groupViewController(), groupViewController()]
        
        return controller
    }
    
    // MARK: - GroupViewController
    
    func groupViewController() -> GroupViewController {
        let model = groupVCModel()
        let controller = GroupViewController(model: model, assembly: self)
        return controller
    }
    
    private func groupVCModel() -> IGroupVCModel {
        return GroupVCModel()
    }
    
}
