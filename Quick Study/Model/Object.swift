//
//  Object.swift
//  Project
//
//  Created by Kirandeep Kaur on 23/3/2024.
//

import Foundation

class Object: Identifiable, Encodable, Decodable, Equatable{
    
    static func == (lhs: Object, rhs: Object) -> Bool {
        // Implement the comparison logic for two Volunteer objects
        return lhs.Name == rhs.Name &&
               lhs.Address == rhs.Address

    }
    
    var Name: String = ""
    var Address: String = ""
    var PhoneNumber: String = ""
    var Cluster: String = ""
}

extension Encodable{
    var toDicitionary: [String: Any?]?{
        guard let data = try? JSONEncoder().encode(self)else{
            return nil
        }
        
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}
