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
    
    @State private var isEditProfileActive = false
    @State private var isChangePasswordActive = false
    
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
                        Button(action: {
                            print("DEBUG: Edit Profile button clicked")
                            isEditProfileActive = true
                        }) {
                            NavigationLink(destination: EditProfileView().navigationBarHidden(true), isActive: $isEditProfileActive) {
                                SettingsRowView(imageName: nil, title: "Edit Profile", tintColor: .black)
                            }
                        }
                        .contentShape(Rectangle())
                       
                        // Change Password
                        Button(action: {
                            print("DEBUG: Change Password button clicked")
                            isChangePasswordActive = true
                        }) {
                            NavigationLink(destination: NewPasswordView().navigationBarHidden(true), isActive: $isChangePasswordActive) {
                                SettingsRowView(imageName: nil, title: "Change Password", tintColor: .black)
                            }
                        }
                        .contentShape(Rectangle())
                        
                        
                        // Notifications
                        HStack {
                            Text("Notifications")
                                .font(.subheadline)
                                .foregroundColor(.black)
                            
                            Spacer()
                        
                        
                            Button(action: {
                                    notificationtoggle.toggle()
                                    print("DEBUG: Notifications toggle is clicked")

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
                                print("DEBUG: Logout Button is clicked")
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                print("fetchUser start")
                Task {
                    do {
                        try await viewModel.fetchUser()
                        print("fetchUser done")
                    } catch {
                        print("Error fetching user: \(error)")
                    }
                }
            }
        }

            
    }
}


#Preview {
    ProfileView()
}
