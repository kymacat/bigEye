//
//  SheduleRow+CoreDataClass.swift
//  Big eye
//
//  Created by Const. on 07.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//
//

import CoreData

@objc(SheduleRow)
public class SheduleRow: NSManagedObject {
    
    func configure(subject: String, teacher: String, startTime: String, endTime: String) {
        self.subject = subject
        self.teacher = teacher
        self.startTime = startTime
        self.endTime = endTime
    }
    
}

extension SheduleRow {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SheduleRow> {
        return NSFetchRequest<SheduleRow>(entityName: "SheduleRow")
    }

    @NSManaged public var startTime: String
    @NSManaged public var endTime: String
    @NSManaged public var subject: String
    @NSManaged public var teacher: String
    @NSManaged public var cell: SheduleCell

}
