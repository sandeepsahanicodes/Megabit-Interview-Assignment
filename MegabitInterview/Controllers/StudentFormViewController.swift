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
    
    let defaults = UserDefaults.standard
    var students = [Student]()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.title = Constants.studentFormTitle
    }
    
    // Navigate form student form VC to student list VC.
    private func navigateToStudentListVC()
    {
        guard let studentListVC = storyboard?.instantiateViewController(withIdentifier: Constants.studentListStoryboardID) else
        {
            print("Failed to create the instance of Student List View Controller!")
            return
        }
        
        self.navigationController?.pushViewController(studentListVC, animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton)
    {
        // Unwrap optional values from text fields.
        guard let firstName = firstName.text,let lastName = lastName.text,let email = email.text,let mobileNumber = mobileNumber.text else
        {
            print("Error while unwrapping optional values from text fields.");
            return
        }
        let student = Student(firstName: firstName, lastName: lastName, email: email , mobileNumber: mobileNumber)
        
        self.students.append(student)
        // UserDefaults can only store pre-defined data types like Date, String, Bool. In order to store custom data type we need some encoding and decoding.
        do
        {
            
            // JSON Encoder
            let encoder = JSONEncoder()
            
            // Encode student
            let encodedStudent = try encoder.encode(students)
            
            // Write it to userDefaults
            defaults.set(encodedStudent, forKey: Constants.userDefaultsKey)
        }
        catch
        {
            print("Unable to encode Student\(error)")
        }
        navigateToStudentListVC()
    
    }
    
}
