//
//  TimetableFileManager.swift
//  Big eye
//
//  Created by Const. on 07.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import CoreData

protocol ITimetableFileManager {
    func saveCell(name: String, rows: [TimetableRowModel])
    func fetchTimetable() -> [SheduleCell]
}

class TimetableFileManager: CoreDataStack, ITimetableFileManager {
    
    func saveCell(name: String, rows: [TimetableRowModel]) {

        guard let entityDescription = NSEntityDescription.entity(forEntityName: "SheduleCell", in: self.managedObjectContext) else {
            print("entity description error")
            return
        }

        let managedObject = SheduleCell(entity: entityDescription, insertInto: self.managedObjectContext)

        managedObject.name = name
        
        for row in rows {
            guard let rowEntityDescription = NSEntityDescription.entity(forEntityName: "SheduleRow", in: self.managedObjectContext) else {
                print("entity description error")
                continue
            }
            let rowManagedObject = SheduleRow(entity: rowEntityDescription, insertInto: self.managedObjectContext)
            
            rowManagedObject.configure(subject: row.subjectNeme, teacher: row.teacher, startTime: row.startTime, endTime: row.endTime)
            
            managedObject.addToRows(rowManagedObject)
        }
        

        self.saveContext(complition: nil)
        
    }
    
    func fetchTimetable() -> [SheduleCell] {
        let fetchRequest = NSFetchRequest<SheduleCell>(entityName: "SheduleCell")
        do {
            let chedule = try self.managedObjectContext.fetch(fetchRequest)
            return chedule
        } catch {
            print(error)
            return []
        }
    }
    
}
