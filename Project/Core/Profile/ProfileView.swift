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
    @State private var notificationtoggle = true
    
    
    var body: some View {
        NavigationView{
            if let user = viewModel.currentUser {
                List{
                    
                    //Header
                    Section{
                        HStack{
                            Text(user.initials)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 72, height: 72)
                                .background(Color(.systemGray3))
                                .clipShape(Circle())
                            
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
                        
                        // Edit Profile
                        NavigationLink(destination: EditProfileView().navigationBarHidden(true)) {
                            SettingsRowView(imageName: nil, title: "Edit Profile",
                                            tintColor: .black)
                        }
                       
                        // Chnage Password
                        NavigationLink(destination: NewPasswordView().navigationBarHidden(true)) {
                            SettingsRowView(imageName: nil, title: "Chnage Password",
                                            tintColor: .black)
                        }
                        
                        // Notifications
                        HStack {
                            Text("Notifications")
                                .font(.subheadline)
                                .foregroundColor(.black)
                            
                            Spacer()
                        
                        
                            Button(action: {
                                    notificationtoggle.toggle()
                                }) {
                                    RoundedRectangle(cornerRadius: 50)
                                        .foregroundColor(notificationtoggle ? .blue : .gray)
                                        .frame(width: 33, height: 18)
                                        .overlay(
                                            Circle()
                                                .foregroundColor(.white)
                                                .frame(width: 17, height: 17)
                                                .offset(x: notificationtoggle ? 07 : -07, y: 0)
                                                .animation(.spring())
                                        )
                                }

                            
                        }
                        
                    
                        
                        NavigationLink(destination: EmptyView(), isActive: $showLogoutConfirmation) {
                            EmptyView()
                        }
                        .overlay(
                            Button(action: {
                                showLogoutConfirmation = true
                            }) {
                                SettingsRowView(imageName: nil,
                                                title: "Logout",
                                                tintColor: .black)
                            }
                            .alert(isPresented: $showLogoutConfirmation) {
                                Alert(title: Text("Confirmation"),
                                      message: Text("Are you sure you want to log out?"),
                                      primaryButton: .cancel(),
                                      secondaryButton: .destructive(Text("Confirm")) {
                                          viewModel.signOut()
                                      }
                                )
                            }
                        )
                        
                    }
                }
            }
        }
            
        }
}

struct Profile: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var navigateToEditProfile = false
    @State private var showLogoutConfirmation = false
    @State private var navigateToNewPassword = false
    
    var body: some View {
        if let user = viewModel.currentUser {
            NavigationView {
                VStack {
                    Section{
                        HStack{
                            Text(user.initials)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 72, height: 72)
                                .background(Color(.systemGray3))
                                .clipShape(Circle())
                            
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
                    }.offset(x: -60, y:-230)
                        .padding(.bottom)
                    
                    Group {
                        VStack(alignment: .leading){
                            HStack {
                                Text("Profile")
                                    .font(Font.custom("Alatsi", size: 20))
                                    .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                                
                                // Add NavigationLink here
                                NavigationLink(destination: EditProfileView().navigationBarHidden(true)) {
                                    Text(">")
                                        .font(Font.custom("Alatsi", size: 20))
                                        .foregroundColor(Color(red: 0.66, green: 0.13, blue: 0.16))
                                }.offset(x: 278)
                                
                            }
                                Divider()
                                
                                HStack{
                                    Text("Change Password")
                                        .font(Font.custom("Alatsi", size: 20))
                                        .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                                    
                                    NavigationLink(
                                        destination: NewPasswordView().navigationBarHidden(true),
                                        label: {
                                            Text(">")
                                                .font(Font.custom("Alatsi", size: 20))
                                                .foregroundColor(Color(red: 0.66, green: 0.13, blue: 0.16))
                                            
                                        }).offset(x: 170)
                                    
                                }
                                Divider()
                                
                                
                                Button{
                                    showLogoutConfirmation = true
                                }label: {
                                    Text("Logout")
                                        .font(Font.custom("Alatsi", size: 20))
                                        .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                                }                    .alert(isPresented: $showLogoutConfirmation){
                                    Alert(title: Text("Confirmation"),
                                          message: Text("Are you sure you want to log out?"),
                                          primaryButton: .cancel(),
                                          secondaryButton: .destructive(Text("Confirm")) {
                                        viewModel.signOut()
                                    })
                                }

                                
                                Divider()
                                
                           
                            
                        }
                        .padding(.leading)
                        
                    }
                    .offset(y: -230)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
