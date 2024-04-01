//
//  VolunteerViewModel.swift
//  Project
//
//  Created by Kirandeep Kaur on 23/3/2024.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class VolunteerViewModel: ObservableObject{
    var ref = Database.database().reference().child("Volunteers")
    
    @Published var value: String? = nil
    @Published var volunteer: Volunteer? = nil
    @Published var listVolunteer = [Volunteer]()
    @Published var filiteredlistVolunteer = [Volunteer]()
    @Published var selectedVolunteer: Volunteer?
    @Published var searchQuery: String = ""
    
    func ListVolunteer(){
        ref.observe(.value){
            parentSnapshot in
            guard let children = parentSnapshot.children.allObjects as? [DataSnapshot] else{
                return
            }
            
            self.listVolunteer = children.compactMap({
                snapshot in return try? snapshot.data(as: Volunteer.self)
            })
        }
    }

    func filterByUniversity(_ university: String) {
        // If the original list is empty, set the listVolunteer to the original list
                guard !listVolunteer.isEmpty else {
                    filiteredlistVolunteer = listVolunteer
                    return
                }
                
                // Filter the listVolunteer by university
        filiteredlistVolunteer = listVolunteer.filter { $0.University == university }
    }

    func filterByMajor(_ major: String) {
        // If the original list is empty, set the listVolunteer to the original list
                guard !listVolunteer.isEmpty else {
                    filiteredlistVolunteer = listVolunteer
                    return
                }
                
                // Filter the listVolunteer by major
                if !major.isEmpty {
                    filiteredlistVolunteer = listVolunteer.filter { $0.Major == major }
                } else {
                    filiteredlistVolunteer = listVolunteer // Reset to the original list when major is empty
                }
    }
}
    
