//
//  Person+CoreDataProperties.swift
//  Big eye
//
//  Created by Const. on 03.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject {
    
    func setup(firstName: String, lastName: String, info: String?, image: Data?) {
        self.firstName = firstName
        self.lastName = lastName
        self.info = info
        self.image = image
    }
    
}

extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var info: String?
    @NSManaged public var image: Data?

}
