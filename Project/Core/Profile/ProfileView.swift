//
//  ProfileView.swift
//  Project
//
//  Created by Gursewak Singh on 21/3/2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @State private var navigateToEditProfile = false
    @State private var showLogoutConfirmation = false
    @State private var navigateToNewPassword = false
    
    
    var body: some View {
        if let user = viewModel.currentUser {
            List{
                Section{
                    HStack{
                        Image("user-square")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        
                        VStack(alignment: .leading, spacing: 4){
                            Text("Hello,")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
                            
                            Text(user.fullname)
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
                        }
                    }
                }
                
                Section("General"){
                    HStack{
                        SettingsRowView(imageName: "gear",
                                        title: "Version",
                                        tintColor: Color(.systemGray))
                        
                        Spacer()
                        
                        Text("1.0.0")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    
                }
                
                Section("Account"){
                    Button{
                        print("Edit Profile...")
                        navigateToEditProfile = true
                    }label: {
                        SettingsRowView(imageName: "arrow.right",
                                        title: "Edit Profile",
                                        tintColor: .black)
                    }
                    .sheet(isPresented: $navigateToEditProfile) {
                        EditProfileView()
                    }
                    
                    
                    Button{
                        print("Change password...")
                        navigateToNewPassword = true
                    }label: {
                        SettingsRowView(imageName: "arrow.right",
                                        title: "Change password",
                                        tintColor: .black)
                    }
                    .sheet(isPresented: $navigateToNewPassword) {
                        NewPasswordView()
                    }
                    
                    Button{
                        print("Notifications...")
                    }label: {
                        SettingsRowView(imageName: "arrow.right",
                                        title: "Notifications",
                                        tintColor: .black)
                    }
                    
                    Button {
                        showLogoutConfirmation = true
                    }label: {
                        SettingsRowView(imageName: "arrow.right.circle.fill",
                                        title: "Logout",
                                        tintColor: .red)
                    }
                    .alert(isPresented: $showLogoutConfirmation){
                        Alert(title: Text("Confirmation"),
                              message: Text("Are you sure you want to log out?"),
                              primaryButton: .cancel(),
                              secondaryButton: .destructive(Text("Confirm")) {
                            viewModel.signOut()
                        })
                    }
                    
                }
            }
        }
    }
}


#Preview {
    ProfileView()
}
