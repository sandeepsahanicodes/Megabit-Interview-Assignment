//
//  StudentListViewController.swift
//  MegabitInterview
//
//  Created by Sandeep Sahani on 25/03/23.
//

import UIKit

class StudentListViewController: UIViewController
{

    @IBOutlet weak var studentListTableView: UITableView!

    let defaults = UserDefaults.standard
    
    // Array for storing students.
    var students = [Student]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.studentListTableView.delegate = self
        self.studentListTableView.dataSource = self
        navigationItem.title = Constants.studentListTitle
    
        decodeStudent()
        
        // Reloading table view after populating Student data.
        DispatchQueue.main.async
        {
            self.studentListTableView.reloadData()
        }
    }
    
    /// Function that decodes encoded Student.
    private func decodeStudent()
    {
        let defaults = UserDefaults.standard
        if let studentData = defaults.value(forKey: Constants.userDefaultsKey) as? Data
        {
            let decoder = JSONDecoder()
            if let decodedStudent = try? decoder.decode([Student].self, from: studentData)
            {
                self.students = decodedStudent
            }
        }
        
    }
    
}

// MARK: Extension for populating table view
extension StudentListViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: StudentListTableViewCell.identifier, for: indexPath) as! StudentListTableViewCell
        
        let fullName = "\(students[indexPath.row].firstName) \(students[indexPath.row].lastName)"
        let email = students[indexPath.row].email
        
        cell.fillStudentData(name: fullName, email: email)
        
        return cell
    }
    
    
}
