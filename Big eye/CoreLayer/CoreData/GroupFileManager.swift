//
//  GroupFileManager.swift
//  Big eye
//
//  Created by Const. on 03.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import CoreData

protocol IGroupFileManager {
    func savePerson(firstName: String, lastName: String, info: String?, image: Data?)
    func fetchPersons() -> [Person]
}

class GroupFileManager: CoreDataStack, IGroupFileManager {
    
    func savePerson(firstName: String, lastName: String, info: String?, image: Data?) {

        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Person", in: self.managedObjectContext) else {
            print("entity description error")
            return
        }

        let managedObject = Person(entity: entityDescription, insertInto: self.managedObjectContext)
        
        managedObject.setup(firstName: firstName, lastName: lastName, info: info, image: image)
        
        self.saveContext(complition: nil)
        
    }
    
    func fetchPersons() -> [Person] {
        let fetchRequest = NSFetchRequest<Person>(entityName: "Person")
        do {
            let persons = try self.managedObjectContext.fetch(fetchRequest)
            return persons
        } catch {
            print(error)
            return []
        }
    }
    
}
