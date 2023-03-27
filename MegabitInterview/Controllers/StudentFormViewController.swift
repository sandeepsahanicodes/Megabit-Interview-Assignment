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
    @IBOutlet weak var warningLabel: UILabel!
    
    var students = [Student]()
    
    // Path where plist will get saved.
    let plistFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(component: "Students.plist")
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.title = Constants.studentFormTitle
        updateWarningLabel(visiblity: 0)
        
    }
    
    /// Navigate form student form VC to student list VC.
    private func navigateToStudentListVC()
    {
        guard let studentListVC = storyboard?.instantiateViewController(withIdentifier: Constants.studentListStoryboardID) else
        {
            print("Failed to create the instance of Student List View Controller!")
            return
        }
        
        self.navigationController?.pushViewController(studentListVC, animated: true)
    }
    
    /// To manipulate warning label.
    private func updateWarningLabel(visiblity: Float)
    {
        warningLabel.layer.opacity = visiblity
        warningLabel.text = Constants.warningMessage
    }
    /// Saving student into plist
    private func saveStudent(with student: Student)
    {
        getStudentList()
        self.students.append(student)
        // Encoder
        let encoder = PropertyListEncoder()
        do
        {
            // Encode student
            let encodedStudent = try encoder.encode(students)
            guard let safeFilePath = plistFilePath else
            {
                print("Unexpectly Found nil while unwrapping optional plist file path!")
                return
            }
            try encodedStudent.write(to: safeFilePath, options: .atomic)
        }
        catch
        {
            print("Unable to encode Student\(error)")
        }
    }
    
    /// Getting student List.
    private func getStudentList()
    {
        guard let safeFilePath = plistFilePath else
        {
            print("Unexpectly Found nil while unwrapping optional plist file path!")
            return
        }
        guard let studentData = try? Data(contentsOf: safeFilePath) else
        {
            print("Unexpectly Found nil while unwrapping optional plist file path!")
            return
        }
        do
        {
            let students = try PropertyListDecoder().decode([Student].self, from: studentData)
            self.students = students
        }
        catch
        {
            print("Error while decoding student list")
        }
        
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton)
    {
        // Unwrap optional values from text fields.
        guard let firstName = firstName.text,let lastName = lastName.text,let email = email.text,let mobileNumber = mobileNumber.text else
        {
            print("Error while unwrapping optional values from text fields.");
            return
        }
        // Check if user entered text fields with empty field.
        if(firstName.isEmpty || lastName.isEmpty || email.isEmpty || mobileNumber.isEmpty)
        {
           updateWarningLabel(visiblity: 1)
        }
        else
        {
            updateWarningLabel(visiblity: 0)
    
            saveStudent(with: Student(firstName: firstName, lastName: lastName, email: email, mobileNumber: mobileNumber))
            
            navigateToStudentListVC()
        }
        
    }
    
}
