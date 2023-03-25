//
//  StudentListTableViewCell.swift
//  MegabitInterview
//
//  Created by Sandeep Sahani on 25/03/23.
//

import UIKit

/// Custom class for student list table view cell.
class StudentListTableViewCell: UITableViewCell
{
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    
    static let identifier = "studentDetailCell"
    public func fillStudentData(name: String,email: String)
    {
        self.name.text = name
        self.email.text = email
    }
    
}
