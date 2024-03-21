//
//  ProfileView.swift
//  Project
//
//  Created by Gursewak Singh on 21/3/2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel : AuthViewModel
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
                        print("Edit profile...")
                    }label: {
                        SettingsRowView(imageName: "arrow.right",
                                        title: "Edit Profile",
                                        tintColor: .black)
                    }
                    
                    Button{
                        print("Chnage password...")
                    }label: {
                        SettingsRowView(imageName: "arrow.right",
                                        title: "Change password",
                                        tintColor: .black)
                    }
                    
                    Button{
                        print("Notifications...")
                    }label: {
                        SettingsRowView(imageName: "arrow.right",
                                        title: "Notifications",
                                        tintColor: .black)
                    }
                    
                    Button{
                        viewModel.signOut()
                    }label: {
                        SettingsRowView(imageName: "arrow.right.circle.fill",
                                        title: "Logout",
                                        tintColor: .red)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
