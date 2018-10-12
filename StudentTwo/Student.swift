//
//  Student.swift
//  StudentTwo
//
//  Created by Jerrick Warren on 10/12/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import Foundation
// Note: these are all now var and it is a class
class Student: CustomStringConvertible, Codable {
    var name: String
    var age: Int?
    var cohort: String?
    
    var description: String {
        var result = "\(name) "
        // testing if there is an empty string or a nil
        if let cohort = cohort {
            result += cohort.isEmpty ? "[unknown cohort]" : cohort
        } else {
            result += " [unknown cohort]"
        }
        if let age = age {
            result += ", Age: \(age)"
        }
        return result
    }
    
    init(name: String, age: Int?, cohort: String?) {
        (self.name, self.age, self.cohort) = (name, age, cohort)
    }
}
