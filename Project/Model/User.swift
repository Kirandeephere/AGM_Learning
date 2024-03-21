//
//  User.swift
//  Project
//
//  Created by Gursewak Singh on 21/3/2024.
//

import Foundation

struct User: Identifiable, Codable{
    let id: String
    let fullname: String
    let email: String
    let phonenumber: String

}

extension User{
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Kirandeep", email: "test@gmail.com", phonenumber: "")
}
