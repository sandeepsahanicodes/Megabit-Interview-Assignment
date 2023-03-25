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
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.studentListTableView.delegate = self
        self.studentListTableView.dataSource = self

    }
    
}

// MARK: Extension for populating table view
extension StudentListViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: StudentListTableViewCell.identifier, for: indexPath) as! StudentListTableViewCell
        
        cell.fillStudentData(name: "Sandeep Sahani", email: "sandeepsahani76j@gmail.com")
        
        return cell
    }
    
    
}
