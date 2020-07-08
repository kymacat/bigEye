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
    
    func groupViewController() -> GroupViewController
    
    func timetableViewController() -> TimetableViewController
    
    func addTimetableRowViewController() -> AddTimetableRowViewController
    
    func markAttendanceViewController(teacher: String, subject: String) -> MarkAttendanceViewController
    
    func statisticsViewController(isPersonallyStatistics: Bool) -> StatisticsViewController
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
        groupController.navigationItem.title = "Группа"
        let navigationGroupController = navigationViewController(with: groupController)
        
        let timetableController = timetableViewController()
        timetableController.navigationItem.title = "Расписание"
        let navigationTimetableController = navigationViewController(with: timetableController)
        
        let statisticsController = statisticsViewController(isPersonallyStatistics: false)
        statisticsController.navigationItem.title = "Статистика"
        controller.swithDelegate = statisticsController
        let navigationStatisticsController = navigationViewController(with: statisticsController)
        
        
        controller.viewControllers = [navigationGroupController, navigationTimetableController, navigationStatisticsController]
        
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
    
    func groupViewController() -> GroupViewController {
        let model = groupVCModel()
        let controller = GroupViewController(model: model, assembly: self)
        
        return controller
    }
    
    private func groupVCModel() -> IGroupVCModel {
        return GroupVCModel(service: serviceAssembly.groupService)
    }
    
    // MARK: - TimetableViewController
    
    func timetableViewController() -> TimetableViewController {
        let model = timetableVCModel()
        let controller = TimetableViewController(model: model, assembly: self)
        
        return controller
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
    
    func statisticsViewController(isPersonallyStatistics: Bool) -> StatisticsViewController {
        let model = statisticsVCModel()
        let controller = StatisticsViewController(model: model, assembly: self, isPersonallyStatistics: isPersonallyStatistics)
        return controller
    }
    
    private func statisticsVCModel() -> IStatisticsVCModel {
        return StatisticsVCModel(service: serviceAssembly.statisticsService)
    }
}
