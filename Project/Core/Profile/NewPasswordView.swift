//
//  NewPasswordView.swift
//  Project
//
//  Created by Gursewak Singh on 22/3/2024.
//

import SwiftUI

struct NewPasswordView: View {
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String = ""
    @State private var successMessage: String = ""
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
                   VStack {
                       //Header
                       HStack{
                           ZStack{
                               RoundedRectangle(cornerRadius: 10)
                                   .foregroundColor(.clear)
                                   .frame(width: 40, height: 40)
                                   .overlay(
                                           RoundedRectangle(cornerRadius: 10)
                                               .stroke(Color.black, lineWidth: 1)
                                       )
                               
                               NavigationLink(
                                   destination: ProfileView().navigationBarHidden(true),
                                   label: {
                                       Image(systemName: "chevron.backward")
                                           .font(Font.custom("Alatsi", size: 15))
                                           .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                                   })
                           }
                           .offset(x: -45, y: 0)
                           
                           Text("Change Password")
                               .font(Font.custom("Alatsi", size: 25))
                               .foregroundColor(Color(red: 0.078, green: 0.13, blue: 0.30))
                               .padding()
                               .offset(x: -30, y: 0)
                          
                       }
                       .offset(x: 0, y: -40)
                      
                       //Image
                       ZStack{
                           Image("restPass")
                               .resizable()
                               .frame(width: 130, height: 130)
                           
                       }.padding(.bottom,40)
                       
                       Text("Current Password")
                           .font(Font.custom("Alatsi", size: 15))
                           .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                           .offset(x: -108.50, y: 0)
                       
                       ZStack {
                           Rectangle()
                               .foregroundColor(.clear)
                               .frame(width: 307, height: 38)
                               .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                               .cornerRadius(5)
                           
                           SecureField("Enter Your Current Password", text: $currentPassword)
                               .offset(x: 65, y: 0)
                       }
                       .padding(.bottom)
                       
                       Text("New Password")
                           .font(Font.custom("Alatsi", size: 15))
                           .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                           .offset(x: -113.50, y: 0)
                       
                       ZStack {
                           Rectangle()
                               .foregroundColor(.clear)
                               .frame(width: 307, height: 38)
                               .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                               .cornerRadius(5)
                           
                           SecureField("Enter Your New Password", text: $newPassword)
                               .offset(x: 65, y: 0)
                       }
                       .padding(.bottom)
                       
                       Text("Confirm New Password")
                           .font(Font.custom("Alatsi", size: 15))
                           .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                           .offset(x: -86, y: 0)
                       
                       ZStack {
                           Rectangle()
                               .foregroundColor(.clear)
                               .frame(width: 307, height: 38)
                               .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                               .cornerRadius(5)
                           
                           SecureField("Enter Your Password Again", text: $confirmPassword)
                               .offset(x: 65, y: 0)
                       }
                       
                       
                       
                       // Rest Button
                       ZStack {
                           Rectangle()
                               .foregroundColor(.clear)
                               .frame(width: 228, height: 38)
                               .background(Color(red: 0.66, green: 0.13, blue: 0.16))
                               .cornerRadius(5)
                               .offset(x: 0, y: 40)
                           
                           Button("Submit") {
                               Task {
                                   do {
                                       try await viewModel.updatePassword(newPassword: newPassword, currentPassword: currentPassword) { error in
                                           if let error = error {
                                               print("Failed to update password with error: \(error.localizedDescription)")
                                           } else {
                                               print("Password updated successfully!")
                                           }
                                       }
                                   } catch {
                                       print("Error: \(error.localizedDescription)")
                                   }
                               }
                           }
                           .font(Font.custom("Alatsi", size: 18))
                            .foregroundColor(.white)
                            .padding(.top, 80)
                       }
                       
                       Group{
                           if !errorMessage.isEmpty {
                               Text(errorMessage)
                                   .foregroundColor(.red)
                                   .padding()
                           }
                           
                           if !successMessage.isEmpty {
                               Text(successMessage)
                                   .foregroundColor(.green)
                                   .padding()
                           }
                       }
                
                   }
               }
           }
    }

#Preview {
    NewPasswordView()
}
