//
//  PresentationAssembly.swift
//  Big eye
//
//  Created by Const. on 30.06.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

protocol IPresentationAssembly {
    
    func eyeTabBarController() -> EyeTabBarController
    
    func groupViewController() -> UINavigationController
    
    func timetableViewController() -> UINavigationController
    
    func addTimetableRowViewController() -> AddTimetableRowViewController
    
    func markAttendanceViewController(teacher: String, subject: String) -> MarkAttendanceViewController
    
    func statisticsViewController() -> UINavigationController
}

class PresentationAssembly: IPresentationAssembly {
    
    private let serviceAssembly: IServicesAssembly
    
    init(serviceAssembly: IServicesAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    // MARK: - EyeTabBarController
    
    func eyeTabBarController() -> EyeTabBarController {
        let controller = EyeTabBarController()
        
        let groupItem = EyeTabBarItem(iconName: "group")
        let timetableItem = EyeTabBarItem(iconName: "calendar")
        let statisticsItem = EyeTabBarItem(iconName: "stat")

        
        controller.setTabBar(items: [groupItem, timetableItem, statisticsItem])
        
        let groupController = groupViewController()
        let timetableController = timetableViewController()
        let statisticsController = statisticsViewController()
        
        controller.swithDelegate = statisticsController.viewControllers.first as? StatisticsViewController
        
        controller.viewControllers = [groupController, timetableController, statisticsController]
        
        return controller
    }
    
    // MARK: - NavigationViewController
    
    private func navigationViewController(with controller: UIViewController) -> UINavigationController {
        
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
         NSAttributedString.Key.font: UIFont(name: "Avenir-Heavy", size: 22)!]
        navigationController.view.backgroundColor = .white
        navigationController.navigationBar.barTintColor = UIColor(red: 200/255, green: 240/255, blue: 255/255, alpha: 1)
        
        return navigationController
    }
    
    // MARK: - GroupViewController
    
    func groupViewController() -> UINavigationController {
        let model = groupVCModel()
        let controller = GroupViewController(model: model, assembly: self)
        controller.navigationItem.title = "Группа"
        
        return navigationViewController(with: controller)
    }
    
    private func groupVCModel() -> IGroupVCModel {
        return GroupVCModel(service: serviceAssembly.groupService)
    }
    
    // MARK: - TimetableViewController
    
    func timetableViewController() -> UINavigationController {
        let model = timetableVCModel()
        let controller = TimetableViewController(model: model, assembly: self)
        controller.navigationItem.title = "Расписание"
        
        return navigationViewController(with: controller)
    }
    
    private func timetableVCModel() -> ITimetableVCModel {
        return TimetableVCModel(service: serviceAssembly.timetableService)
    }
    
    // MARK: - AddTimetableViewController
    
    func addTimetableRowViewController() -> AddTimetableRowViewController {
        let controller = AddTimetableRowViewController()
        return controller
    }
    
    // MARK: - MarkAttendanceViewController
    
    func markAttendanceViewController(teacher: String, subject: String) -> MarkAttendanceViewController {
        let model = markAttendanceVCModel()
        let controller = MarkAttendanceViewController(model: model, teacher: teacher, subject: subject)
        return controller
    }
    
    private func markAttendanceVCModel() -> IMarkAttendanceVCModel {
        return MarkAttendanceVCModel(service: serviceAssembly.markAttendanceService)
    }
    
    // MARK: - StatisticsViewController
    
    func statisticsViewController() -> UINavigationController {
        let model = statisticsVCModel()
        let controller = StatisticsViewController(model: model, assembly: self)
        controller.navigationItem.title = "Статистика"
        return navigationViewController(with: controller)
    }
    
    private func statisticsVCModel() -> IStatisticsVCModel {
        return StatisticsVCModel(service: serviceAssembly.statisticsService)
    }
}
