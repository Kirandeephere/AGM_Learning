//
//  Volunteer.swift
//  Project
//
//  Created by Kirandeep Kaur on 23/3/2024.
//

import Foundation

class Volunteer: Identifiable, Decodable, Equatable {
    static func == (lhs: Volunteer, rhs: Volunteer) -> Bool {
        // Implement the comparison logic for two Volunteer objects
        return lhs.ID == rhs.ID &&
               lhs.Name == rhs.Name &&
               lhs.University == rhs.University &&
               lhs.Major == rhs.Major
    }

    var ID: String = ""
    var Name: String = ""
    var University: String = ""
    var Major: String = ""
    var About: String = ""
}

