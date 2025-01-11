//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Polanki Varun Kumar on 11/01/25.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    let personManager = CoreDataManager<Person>.shared(for: Person.self)
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
   
    @IBAction func Save(_ sender: Any) {
        personManager.save(entityName: "Person", values: ["name": "Varun kumar", "age": 29])
    }
    
    @IBAction func fetchAction(_ sender: Any) {
       let fetechedData = personManager.fetch(entityName: "Person")
        if !fetechedData.isEmpty{
            for i in fetechedData {
                print("name is  \(i.name)")
                print("age is \(i.age)")
            }
        } else {
            print("data not found")
        }
    }
    
    @IBAction func updateAction(_ sender: Any) {
        let fetchedPeople = personManager.fetch(entityName: "Person")
        if let personToUpdate = fetchedPeople.first {
            personManager.update(personToUpdate, with: ["name": "Vamsi krishna", "age": 30])
        }
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        let fetchedPeople = personManager.fetch(entityName: "Person")
        if let personToDelete = fetchedPeople.last {
            personManager.delete(personToDelete)
        }
    }
}

