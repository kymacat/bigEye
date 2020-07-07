//
//  SheduleCell+CoreDataClass.swift
//  Big eye
//
//  Created by Const. on 07.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//
//

import CoreData

@objc(SheduleCell)
public class SheduleCell: NSManagedObject {

}

extension SheduleCell {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SheduleCell> {
        return NSFetchRequest<SheduleCell>(entityName: "SheduleCell")
    }

    @NSManaged public var name: String
    @NSManaged public var rows: NSSet

}

// MARK: Generated accessors for rows
extension SheduleCell {

    @objc(addRowsObject:)
    @NSManaged public func addToRows(_ value: SheduleRow)

    @objc(removeRowsObject:)
    @NSManaged public func removeFromRows(_ value: SheduleRow)

    @objc(addRows:)
    @NSManaged public func addToRows(_ values: NSSet)

    @objc(removeRows:)
    @NSManaged public func removeFromRows(_ values: NSSet)

}
