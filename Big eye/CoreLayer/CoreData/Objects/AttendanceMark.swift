//
//  AttendanceMark+CoreDataClass.swift
//  
//
//  Created by Const. on 08.07.2020.
//
//

import Foundation
import CoreData

@objc(AttendanceMark)
public class AttendanceMark: NSManagedObject {

}

extension AttendanceMark {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AttendanceMark> {
        return NSFetchRequest<AttendanceMark>(entityName: "AttendanceMark")
    }

    @NSManaged public var mark: Bool
    @NSManaged public var firstName: String
    @NSManaged public var lastName: String
    @NSManaged public var statistics: StatisticsCell

}
