//
//  FirstLoadController.swift
//  exam
//
//  Created by Chen ChiYun on 06/02/2018.
//  Copyright © 2018 Chen ChiYun. All rights reserved.
//
import CoreData
import UIKit

//this class is for caching json to CoreData
class FirstLoadController: UIViewController {

    var personsArray: [Persons] = []
    var fetchCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        check if something in Local Storage
        fetchDatafromLocaltoPersons()
        if personsArray == [] {
            for _ in 1...6 {
                saveJSONtoLocal()
            }
            performSegue(withIdentifier: "firstLoadtoList", sender: self)
        } else {
            //if array has json data, go straight to list
            performSegue(withIdentifier: "firstLoadtoList", sender: self)
        }
//        clean database for testing
//        deleteItem()
    }
    
    
    func saveJSONtoLocal() {
        if let url = URL(string: "https://randomapi.com/api/rk0ljla8?key=N79B-49S2-VZ81-HC9O") {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: data!, options: [JSONSerialization.ReadingOptions.mutableContainers]) as! NSDictionary
                    let json = jsonResult["results"] as? NSArray
                    if let jsonArray = json![0] as? NSDictionary{
                        DispatchQueue.main.async {
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            let context = appDelegate.persistentContainer.viewContext
                            let persons = Persons(context: context)
                            persons.firstname = jsonArray["firstname"] as? String
                            persons.lastname = jsonArray["lastname"] as? String
                            persons.birthday = jsonArray["birthday"] as? String
                            persons.email = jsonArray["email"] as? String
                            persons.mobile = jsonArray["mobile"] as? String
                            persons.address = jsonArray["address"] as? String
                            persons.contactperson = jsonArray["contactperson"] as? String
                            persons.contactpersonphone = jsonArray["contactpersonphone"] as? String
                            persons.age = String(self.calculateAge(birthday: (jsonArray["birthday"] as? String)!))
                            do {
                                try context.save()
                                self.fetchCount += 1
                            } catch {
                                print("There was an error.")
                            }
                            
                        }
                    }
                } catch let err {
                    print(err)
                }
            }.resume()
        }
    }
    
    func fetchDatafromLocaltoPersons(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Persons>(entityName: "Persons")
        do{
            personsArray = try context.fetch(fetchRequest)
        }catch{
            print("Data could not be fetch.")
        }
    }
    
    func deleteItem(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Persons")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func calculateAge(birthday: String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM/dd/yyyy"
        let birthdayDate = dateFormater.date(from: birthday)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
        let age = calcAge.year
        return age!
    }
    
    
}
