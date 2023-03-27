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
    
    // Array for storing students.
    var students = [Student]()
    
    let plistFilePath = FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask).first?.appending(component: "Students.plist")
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.studentListTableView.delegate = self
        self.studentListTableView.dataSource = self
        navigationItem.title = Constants.studentListTitle
        // print(dataFilePath)
        getStudents()
        
    }
    
    /// Retrive student list from plist file.
    private func getStudents()
    {
        guard let safeFilePath = plistFilePath else
        {
            print("Error while unwrapping data file path!")
            return
        }
        
        guard let studentData = try? Data(contentsOf: safeFilePath) else
        
        {
            print("An error is thrown while fetching contents of plist file")
            return
        }
        
        let decoder = PropertyListDecoder()
        do
        {
            self.students = try decoder.decode([Student].self, from: studentData)
            // Reloading table view after populating Student data.
            DispatchQueue.main.async
            {
                self.studentListTableView.reloadData()
            }
        }
        catch
        {
            print("Error decoding data \(error)")
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
