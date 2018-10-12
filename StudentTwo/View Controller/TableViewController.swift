//
//  TableViewController.swift
//  StudentTwo
//
//  Created by Jerrick Warren on 10/12/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    @IBOutlet var studentManager: StudentManager!
    
    // MARK: - Data Model
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentManager.students.count
    }
    
    let reuseIdentifier = "cell"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = studentManager.students[indexPath.row].description
        return cell
    }
    
    // MARK: - Table Delegate
    
    // Enable "magic" swipe-to-delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // Only handle deletions
        guard editingStyle == .delete else { return }
        
        // Update model then refresh view
        studentManager.removeRecord(at: indexPath.row)
        studentManager.writeToFile()
        tableView.reloadData()
    }
    
    // MARK: - Data exchange with other controllers
    
    
    @IBAction func unwindFor(_ unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        guard let source = unwindSegue.source as? StudentViewController
            else { return }
        
        // Don't ever touch view from segue, only state
        // only will add a student if there is nothing there
        if source.student == nil,
            let studentRecord = source.studentRecord() {
            studentManager.addRecord(studentRecord)
        }
        
        // If a student record was edited, it's ready to write
        // without further work because of viewWillDisappear
        studentManager.writeToFile()
        self.tableView.reloadData()
    }
    
    let editRecordIdentifier = "editRecord"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // fetch destination and cast it to the right (StudentViewController) type
        // this is modal segue that take 2 steps
        guard
            let navigationController = segue.destination as? UINavigationController,
            let destination = navigationController.topViewController as? StudentViewController
            else { return }
        
        // Only prepare if we're working with the edit version
        guard segue.identifier == editRecordIdentifier
            else { destination.student = nil; return }
        
        guard let indexPath = tableView.indexPathForSelectedRow
            else { return }
        
        // set some kind of student data record and figure out how you'll know
        // whether the record will be edited when control returns to you
        destination.student = studentManager.record(at: indexPath.row)
    }
    
}
