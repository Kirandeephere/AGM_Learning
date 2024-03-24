//
//  EditProfileView.swift
//  Project
//
//  Created by Gursewak Singh on 22/3/2024.
//

import SwiftUI

struct EditProfileView: View {
    @State private var fullname = ""
    @State private var email = ""
    @State private var phonenumber = ""
    @State private var errorMessage: String?
    @State private var successMessage: String = ""
    @State private var navigateToHome = false
    @State private var updateStatusMessage: String = ""
    
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        NavigationView{
            VStack{
                
                Group{
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
                        
                        Text("Profile")
                            .font(Font.custom("Alatsi", size: 25))
                            .foregroundColor(Color(red: 0.078, green: 0.13, blue: 0.30))
                            .offset(x: -20, y: 0)
                        
                    }
                    .offset(x: -50, y: -30)
                    
                    
                    //Image
                    ZStack{
                        Image("usericon")
                            .resizable()
                            .frame(width: 130, height: 130)
                        
                    }.padding(.bottom, 30)
                };
                
                Group{
                    Text("Full Name")
                        .font(Font.custom("Alatsi", size: 15))
                        .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                        .offset(x: -129, y: 0)
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 307, height: 38)
                            .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                            .cornerRadius(5)
                        
                        TextField("Enter Your Full Name", text: $fullname)
                            .offset(x: 65, y: 0)
                        
                    }
                    
                    Text("Email ID")
                        .font(Font.custom("Alatsi", size: 15))
                        .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                        .offset(x: -135, y: 0)
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 307, height: 38)
                            .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                            .cornerRadius(5)
                        
                        TextField("Enter Your Email Address", text: $email)
                            .offset(x: 65, y: 0)
                            .textInputAutocapitalization(.never)
                        
                    }
                    
                    Text("Phone Number")
                        .font(Font.custom("Alatsi", size: 15))
                        .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                        .offset(x: -113, y: 0)
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 307, height: 38)
                            .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                            .cornerRadius(5)
                        
                        TextField("Enter Your Phone Number", text: $phonenumber)
                            .offset(x: 65, y: 0)
                        
                    }
                    
                };
                
                
                //Update Profile Button
                Button(action: {
                    Task {
                        do {
                            try await viewModel.updateUserInfo(fullname: fullname, email: email, phonenumber: phonenumber)
                            navigateToHome = true
                        } catch {
                            // Handle error
                            errorMessage = error.localizedDescription
                        }
                    }
                }) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(red: 0.66, green: 0.13, blue: 0.16))
                            .frame(width: 228, height: 38)
                            .cornerRadius(5)
                        Text("Send")
                            .font(Font.custom("Alatsi", size: 18))
                            .foregroundColor(.white)
                    }
                }
                .disabled(!formisValid)
                .opacity(formisValid ? 1.0 : 0.5)
                .offset(x: 0, y: 40)
                .background(
                    NavigationLink(destination: HomeView().navigationBarHidden(true), isActive: $navigateToHome) {
                        EmptyView()
                    }
                    .hidden()
                )
            }
            
        }
    }
}


//MARK- FORM VALIDATION
extension EditProfileView: AuthenticationFormProtocol{
    var formisValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !fullname.isEmpty
        && !phonenumber.isEmpty
        && phonenumber.count >= 8
        
    }
}

#Preview {
    EditProfileView()
}
