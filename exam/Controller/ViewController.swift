//
//  ViewController.swift
//  exam
//
//  Created by Chen ChiYun on 06/02/2018.
//  Copyright © 2018 Chen ChiYun. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var personsArray: [Persons] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        cell.textLabel?.text = (personsArray[indexPath.row].firstname)! + "   " + (personsArray[indexPath.row].lastname)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = personsArray[indexPath.row]
        performSegue(withIdentifier: "ShowDetail", sender: person)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let detailViewController = segue.destination as? DetailViewController {
                if let person = sender as? Persons {
                    detailViewController.firstName = person.firstname!
                    detailViewController.lastName = person.lastname!
                    detailViewController.age = person.age!
                    detailViewController.birthday = person.birthday!
                    detailViewController.address = person.address!
                    detailViewController.mobile = person.mobile!
                    detailViewController.email = person.email!
                    detailViewController.contactPerson = person.contactperson!
                    detailViewController.contactPersonPhone = person.contactpersonphone!
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDatafromLocaltoPersons()
        /* swipe down to refresh list,
        only refresh for the first time*/
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
    }
    
    @objc func handleRefresh() {
        fetchDatafromLocaltoPersons()
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    func fetchDatafromLocaltoPersons(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Persons>(entityName: "Persons")
        do{
            self.personsArray = try context.fetch(fetchRequest)
        }catch{
            print("Data could not be fetch.")
        }
    }
    
    
}

