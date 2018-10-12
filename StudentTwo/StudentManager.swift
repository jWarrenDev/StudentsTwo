//
//  StudentManager.swift
//  StudentTwo
//
//  Created by Jerrick Warren on 10/12/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import Foundation

class StudentManager: NSObject {
    var students: [Student] = []
    
    let url = URL(fileURLWithPath: NSHomeDirectory())
        .appendingPathComponent("Documents")
        .appendingPathComponent("students.json")
    
    func writeToFile() {
        do {
            let data = try JSONEncoder().encode(students)
            try data.write(to: url)
        } catch {
            print("Error while saving students: \(error)")
            return
        }
    }
    
    func readFromFile() {
        do {
            let data = try Data(contentsOf: url)
            let records = try JSONDecoder().decode([Student].self, from: data)
            students.append(contentsOf: records)
        } catch {
            print("Error while reading students: \(error)")
            return
        }
    }
    
    func addRecord(_ student: Student) {
        students.append(student)
    }
    
    func removeRecord(at idx: Int) {
        students.remove(at: idx)
    }
    
    func record(at idx: Int) -> Student {
        return students[idx]
    }
    
    // Yesterday, the read was done from the main controller's
    // viewWillAppear. This is different.
    override init() {
        super.init()
        readFromFile()
    }
}

