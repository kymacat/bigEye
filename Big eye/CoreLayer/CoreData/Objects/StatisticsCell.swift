//
//  StatisticsCell+CoreDataClass.swift
//  
//
//  Created by Const. on 08.07.2020.
//
//

import Foundation
import CoreData

@objc(StatisticsCell)
public class StatisticsCell: NSManagedObject {

}

extension StatisticsCell {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StatisticsCell> {
        return NSFetchRequest<StatisticsCell>(entityName: "StatisticsCell")
    }

    @NSManaged public var date: Date
    @NSManaged public var subject: String
    @NSManaged public var teacher: String
    @NSManaged public var attendenceMarks: NSSet

}

// MARK: Generated accessors for attendenceMarks
extension StatisticsCell {

    @objc(addAttendenceMarksObject:)
    @NSManaged public func addToAttendenceMarks(_ value: AttendanceMark)

    @objc(removeAttendenceMarksObject:)
    @NSManaged public func removeFromAttendenceMarks(_ value: AttendanceMark)

    @objc(addAttendenceMarks:)
    @NSManaged public func addToAttendenceMarks(_ values: NSSet)

    @objc(removeAttendenceMarks:)
    @NSManaged public func removeFromAttendenceMarks(_ values: NSSet)

}
