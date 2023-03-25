//
//  StudentFormViewController.swift
//  MegabitInterview
//
//  Created by Sandeep Sahani on 25/03/23.
//

import UIKit

class StudentFormViewController: UIViewController
{
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var addButtonTapped: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Student Form"
        
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton)
    {
        print(firstName.text)
        print(lastName.text)
        print(email.text)
        print(mobileNumber.text)
    
    }
    
}
