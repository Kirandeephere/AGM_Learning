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
                                        .font(Font.custom("Alatsi-Regular", size: 15))
                                        .foregroundColor(Color(hex: 0x14214C))
                                })
                        }
                        .offset(x: -45, y: 0)
                        
                        Text("Sign Up")
                            .font(Font.custom("Alatsi-Regular", size: 25))
                            .foregroundColor(Color(hex: 0x14214C))
                            .offset(x: -20, y: 0)
                        
                    }
                    .offset(x: -50, y: 0)
                    
                    
                    //Image
                    ZStack{
                        Image("usericon")
                            .resizable()
                            .frame(width: 130, height: 130)
                        
                    }
                };
                
                Group{
                    Text("Full Name")
                        .font(Font.custom("Alatsi-Regular", size: 15))
                        .foregroundColor(Color(hex: 0x737373))
                        .offset(x: -100, y: 0)
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 307, height: 38)
                            .foregroundColor(Color(hex: 0xECECEC))
                            .cornerRadius(5)
                        
                        TextField("Enter Your Full Name", text: $fullname)
                            .offset(x: 65, y: 0)
                            .foregroundColor(Color(hex: 0x808080))
                        
                    }
                    .padding(.bottom, 15)

                    
                    Text("Email Address")
                        .font(Font.custom("Alatsi-Regular", size: 15))
                        .foregroundColor(Color(hex: 0x737373))
                        .offset(x: -85, y: 0)
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 307, height: 38)
                            .foregroundColor(Color(hex: 0xECECEC))
                            .cornerRadius(5)
                        
                        TextField("Enter Your Email Address", text: $email)
                            .foregroundColor(Color(hex: 0x808080))
                            .offset(x: 65, y: 0)
                            .textInputAutocapitalization(.never)
                        
                    }
                    .padding(.bottom, 15)

                    
                    Text("Phone Number")
                        .font(Font.custom("Alatsi-Regular", size: 15))
                        .foregroundColor(Color(hex: 0x737373))
                        .offset(x: -85, y: 0)
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 307, height: 38)
                            .foregroundColor(Color(hex: 0xECECEC))
                            .cornerRadius(5)
                        
                        TextField("Enter Your Phone Number", text: $phonenumber)
                            .offset(x: 65, y: 0)
                            .foregroundColor(Color(hex: 0x808080))
                        
                    }
                    .padding(.bottom, 15)

                    
                    Text("Password")
                        .font(Font.custom("Alatsi-Regular", size: 15))
                        .foregroundColor(Color(hex: 0x737373))
                        .offset(x: -100, y: 0)
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 307, height: 38)
                            .foregroundColor(Color(hex: 0xECECEC))
                            .cornerRadius(5)
                        
                        SecureField("Enter Your Password", text: $password)
                            .offset(x: 65, y: 0)
                            .foregroundColor(Color(hex: 0x808080))
                        
                    }
                    .padding(.bottom, 15)
                    
                    Text("Confirm Password")
                        .font(Font.custom("Alatsi-Regular", size: 15))
                        .foregroundColor(Color(hex: 0x737373))
                        .offset(x: -75, y: 0)
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 307, height: 38)
                            .foregroundColor(Color(hex: 0xECECEC))
                            .cornerRadius(5)
                        
                        SecureField("Enter Your Password Again", text: $confrimpassword)
                            .offset(x: 65, y: 0)
                            .foregroundColor(Color(hex: 0x808080))
                        
                    }
                    .padding(.bottom, 15)

                };
                
               
                //Sign IN Button
                Button{
                    Task{
                        try await viewModel.createUser(withEmail: email, password: password, fullname: fullname, phonenumber: phonenumber)
                    }
                }label: {
                    Text("Sign Up")
                        .font(Font.custom("Alatsi-Regular", size: 18))
                        .foregroundColor(.white)
                    }
                    .frame(width: 228, height: 38)
                    .background(Color(hex: 0xA92028))
                    .disabled(!formisValid)
                    .opacity(formisValid ? 1.0 : 0.5)
                    .cornerRadius(5)
                    .offset(x: 0, y: 20)
                
                
                HStack{
                    
                    Text("Already have an account?")
                        .font(Font.custom("Alatsi-Regular", size: 15))
                        .foregroundColor(Color(hex: 0x737373))
                    
                    NavigationLink(
                        destination: LoginView().navigationBarHidden(true),
                        label: {
                            Text("Sign In")
                                .font(Font.custom("Alatsi", size: 15))
                                .foregroundColor(Color(hex: 0x000000))

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
