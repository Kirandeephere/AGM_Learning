//
//  AuthViewModel.swift
//  Project
//
//  Created by Gursewak Singh on 21/3/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol{
    var formisValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init(){
        self.userSession = Auth.auth().currentUser
        
        Task{
            await fetchUser()
        }
    }
    
    //Firebase SignIn Function
    func signIn(withEmail email: String, password: String) async throws{
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        }catch{
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    
    
    //Firebase Create New User Function
    func createUser(withEmail email: String, password: String, fullname: String, phonenumber: String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            
            let user = User(id: result.user.uid, fullname: fullname, email: email, phonenumber: phonenumber)
            let encodedUser = try Firestore.Encoder().encode(user) 
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        }catch  {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    
    
    //Firebase Sign Out Function
    func signOut(){
        do{
            try Auth.auth().signOut()
            self.userSession = nil //Wipes out user session and takes back to login
            self.currentUser = nil //Wipes out current user data model
        }catch{
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    
    
    //Firebase Delete Account Function
    func deleteAccount(){
        
    }
    
    
    
    //Firebase Fetech User Data Function
    func fetchUser() async{
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapcaht = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapcaht.data(as: User.self)
        
        print("DEBUG: Current user is \(self.currentUser)")

    }
    
    
    
    //Firebase Reset Password Function
    func resetPassword(forEmail email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("DEBUG: Failed to send password reset email with error \(error.localizedDescription)")
            } else {
                print("DEBUG: Password reset email sent successfully")
            }
        }
    }
    
    
    
    //Firebase Update User Account Function
    func updateUserInfo(fullname: String, email: String, phonenumber: String) {
        guard let currentUser = Auth.auth().currentUser else {
            print("No current user found")
            return
        }
        
        let userRef = Firestore.firestore().collection("users").document(currentUser.uid)
        
        userRef.updateData([
            "fullname": fullname,
            "email": email,
            "phonenumber": phonenumber
            // Add other fields you want to update here
        ]) { error in
            if let error = error {
                print("Error updating user information: \(error)")
            } else {
                print("User information updated successfully")
            }
        }
    }
}
