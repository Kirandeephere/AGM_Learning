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
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
            
            // Show a dialog indicating incorrect email or password
            let alertController = UIAlertController(
                title: "Login Error",
                message: "Incorrect email or password",
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            // Present the alert controller
            if let currentViewController = UIApplication.shared.windows.first?.rootViewController {
                currentViewController.present(alertController, animated: true, completion: nil)
            }
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
            // print("DEBUG: User created successfully")
        }catch  {
            print("Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    
    
    //Firebase Sign Out Function
    func signOut(){
        do{
            try Auth.auth().signOut()
            self.userSession = nil //Wipes out user session and takes back to login
            self.currentUser = nil //Wipes out current user data model
            // print("DEBUG: User has been logged out successfully")
        }catch{
            print("Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    
    
    //Firebase Delete Account Function
    func deleteAccount(){
        
    }
    
    
    
    //Firebase Fetech User Data Function
    func fetchUser() async {
            guard let uid = Auth.auth().currentUser?.uid else { return }

            do {
                let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
                self.currentUser = try snapshot.data(as: User.self)
                
                // print("DEBUG: Current user is \(self.currentUser)")
            } catch {
                print("Error fetching user: \(error)")
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
    
    
    
    //Firebase Reset User Password Function
    func updatePassword(newPassword: String, currentPassword: String, completion: @escaping (Error?) -> Void) {
        if let currentUser = Auth.auth().currentUser {
            let credential = EmailAuthProvider.credential(withEmail: currentUser.email ?? "", password: currentPassword)
            currentUser.reauthenticate(with: credential) { _, error in
                if let error = error {
                    completion(error)
                } else {
                    currentUser.updatePassword(to: newPassword) { error in
                        completion(error)
                    }
                }
            }
        } else {
            let error = NSError(domain: "com.yourapp.error", code: -1, userInfo: [NSLocalizedDescriptionKey: "No current user found"])
            completion(error)
        }
    }
    
    
    
    //New Functions
    
}
