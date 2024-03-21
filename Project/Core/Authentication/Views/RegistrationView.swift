//
//  RegistrationView.swift
//  Project
//
//  Created by Gursewak Singh on 21/3/2024.
//

import SwiftUI

struct RegistrationView: View {
    @State private var fullname = ""
    @State private var email = ""
    @State private var phonenumber = ""
    @State private var password = ""
    @State private var confrimpassword = ""
    @Environment(\.dismiss) var dismiss
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
                                destination: LoginView().navigationBarHidden(true),
                                label: {
                                    Image(systemName: "chevron.backward")
                                        .font(Font.custom("Alatsi", size: 15))
                                        .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                                })
                        }
                        .offset(x: -45, y: 0)
                        
                        Text("Sign Up")
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
                    
                    Text("Email Address")
                        .font(Font.custom("Alatsi", size: 15))
                        .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                        .offset(x: -115, y: 0)
                    
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
                    
                    Text("Password")
                        .font(Font.custom("Alatsi", size: 15))
                        .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                        .offset(x: -130, y: 0)
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 307, height: 38)
                            .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                            .cornerRadius(5)
                        
                        SecureField("Enter Your Password", text: $password)
                            .offset(x: 65, y: 0)
                        
                    }
                    
                    Text("Confirm Password")
                        .font(Font.custom("Alatsi", size: 15))
                        .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                        .offset(x: -100, y: 0)
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 307, height: 38)
                            .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                            .cornerRadius(5)
                        
                        SecureField("Enter Your Password Again", text: $confrimpassword)
                            .offset(x: 65, y: 0)
                        
                    }
                };
                
               
                //Sign IN Button
                Button{
                    Task{
                        try await viewModel.createUser(withEmail: email, password: password, fullname: fullname, phonenumber: phonenumber)
                    }
                }label: {
                    Text("Sign Up")
                        .font(Font.custom("Alatsi", size: 18))
                        .foregroundColor(.white)
                    
                }.foregroundColor(.clear)
                    .frame(width: 228, height: 38)
                    .background(Color(red: 0.66, green: 0.13, blue: 0.16))
                    .disabled(!formisValid)
                    .opacity(formisValid ? 1.0 : 0.5)
                    .cornerRadius(5)
                    .offset(x: 0, y: 20)
                
                
                HStack{
                    
                    Text("Already have an account?")
                        .font(Font.custom("Alatsi", size: 15))
                        .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                    
                    NavigationLink(
                        destination: LoginView().navigationBarHidden(true),
                        label: {
                            Text("Sign In")
                                .font(Font.custom("Alatsi", size: 15))
                                .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                            
                        })
                    
                }.offset(x: 0, y: 40)
                
            }
            
        }
        
    }
}


//MARK- FORM VALIDATION
extension RegistrationView: AuthenticationFormProtocol{
    var formisValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confrimpassword == password
        && !fullname.isEmpty
        && !phonenumber.isEmpty
        && phonenumber.count >= 8
        
    }
}

#Preview {
    RegistrationView()
}
