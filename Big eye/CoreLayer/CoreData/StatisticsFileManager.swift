//
//  StatisticsFileManager.swift
//  Big eye
//
//  Created by Const. on 08.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import CoreData

protocol IStatisticsFileManager {
    func saveReport(date: Date, teacher: String, subject: String, marks: [AttendanceModel])
    func fetchStatistics() -> [StatisticsCell]
}

class StatisticsFileManager: CoreDataStack, IStatisticsFileManager {
    
    func saveReport(date: Date, teacher: String, subject: String, marks: [AttendanceModel]) {
        
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "StatisticsCell", in: self.managedObjectContext) else {
            print("entity description error")
            return
        }
        
        let managedObject = StatisticsCell(entity: entityDescription, insertInto: self.managedObjectContext)
        
        managedObject.date = date
        managedObject.subject = subject
        managedObject.teacher = teacher
        
        for mark in marks {
            guard let entityDescription = NSEntityDescription.entity(forEntityName: "AttendanceMark", in: self.managedObjectContext) else {
                print("entity description error")
                return
            }
            let markObject = AttendanceMark(entity: entityDescription, insertInto: self.managedObjectContext)
            
            markObject.firstName = mark.person.firstName
            markObject.lastName = mark.person.lastName
            markObject.mark = mark.isAttended
            
            managedObject.addToAttendenceMarks(markObject)
        }
        
        self.saveContext(complition: nil)
        
    }
    
    func fetchStatistics() -> [StatisticsCell] {
        let fetchRequest = NSFetchRequest<StatisticsCell>(entityName: "StatisticsCell")
        do {
            let chedule = try self.managedObjectContext.fetch(fetchRequest)
            return chedule
        } catch {
            print(error)
            return []
        }
    }
    
}
