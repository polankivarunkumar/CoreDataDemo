//
//  CoreDataManager.swift
//  CoreDataDemo
//
//  Created by Polanki Varun Kumar on 11/01/25.
//

import CoreData
import UIKit

class CoreDataManager<T: NSManagedObject> {

    static func shared(for entity: T.Type) -> CoreDataManager<T> {
        return CoreDataManager<T>()
    }

    private let context: NSManagedObjectContext

    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unable to get AppDelegate")
        }
        self.context = appDelegate.persistentContainer.viewContext
    }

    func save(entityName: String, values: [String: Any]) {
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)!
        let object = NSManagedObject(entity: entity, insertInto: context)

        values.forEach { key, value in
            object.setValue(value, forKey: key)
        }

        do {
            try context.save()
            print("\(entityName) saved successfully.")
        } catch {
            print("Failed to save \(entityName): \(error.localizedDescription)")
        }
    }

    func fetch(entityName: String) -> [T] {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)

        do {
            let entities = try context.fetch(fetchRequest)
            return entities
        } catch {
            print("Failed to fetch \(entityName): \(error.localizedDescription)")
            return []
        }
    }

    func delete(_ object: T) {
        context.delete(object)
        do {
            try context.save()
            print("Entity deleted successfully.")
        } catch {
            print("Failed to delete entity: \(error.localizedDescription)")
        }
    }

    func update(_ object: T, with values: [String: Any]) {
        values.forEach { key, value in
            object.setValue(value, forKey: key)
        }

        do {
            try context.save()
            print("Entity updated successfully.")
        } catch {
            print("Failed to update entity: \(error.localizedDescription)")
        }
    }
}
