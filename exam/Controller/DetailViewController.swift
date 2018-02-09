//
//  DetailViewController.swift
//  exam
//
//  Created by Chen ChiYun on 06/02/2018.
//  Copyright © 2018 Chen ChiYun. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var lblFirstName: UILabel!
    
    @IBOutlet weak var lblLastName: UILabel!
    
    @IBOutlet weak var lblAge: UILabel!
    
    @IBOutlet weak var lblBirthday: UILabel!
    
    @IBOutlet weak var lblMobile: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var lblContactPerson: UILabel!
    
    @IBOutlet weak var lblContactPersonPhone: UILabel!
    
    var firstName: String?
    var lastName: String?
    var age: String?
    var birthday: String?
    var mobile: String?
    var address: String?
    var email: String?
    var contactPerson: String?
    var contactPersonPhone: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblFirstName.text = "FirstName:" + "   " + firstName!
        lblLastName.text = "LastName:" + "   " + lastName!
        lblAge.text = "Age:" + "   " + age!
        lblBirthday.text = "Birthday:" + "   " + birthday!
        lblMobile.text = "Mobile:" + "   " + mobile!
        lblAddress.text = "Address:" + "   " + address!
        lblEmail.text = "Email:" + "   " + email!
        lblContactPerson.text = "Contact Person:" + "   " + contactPerson!
        lblContactPersonPhone.text = "Contact Person Phone:" + "   " + contactPersonPhone!
        
        //swipe right back to list 
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handlePop))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
    }
    @objc func handlePop() {
        self.dismiss(animated: true, completion: nil)
    }
}
