//
//  LoginView.swift
//  Project
//
//  Created by Gursewak Singh on 21/3/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""

    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Image("splashlogo")
                    .resizable()
                    .frame(width: 260, height: 100)
                    .padding(.bottom, 20)
                
                Text("Sign in")
                    .font(Font.custom("Alatsi", size: 25))
                    .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                    .offset(x: -119.50, y: -0)
                    .padding(.bottom, 5)
                
                Text("Email Address")
                    .font(Font.custom("Alatsi", size: 15))
                    .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                    .offset(x: -113.50, y: 0)
                
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
                
                Text("Password")
                    .font(Font.custom("Alatsi", size: 15))
                    .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                    .offset(x: -128, y: 0)
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 307, height: 38)
                        .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                        .cornerRadius(5)
                    
                    SecureField("Enter Your Password", text: $password)
                        .offset(x: 65, y: 0)
                }
                
                NavigationLink(
                    destination: ForgetPasswordView().navigationBarHidden(true),
                    label: {
                        Text("Forgot Password")
                            .font(Font.custom("Alatsi", size: 15))
                            .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                            .padding(.leading, 200)
                        
                    })
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 228, height: 38)
                        .background(Color(red: 0.66, green: 0.13, blue: 0.16))
                        .cornerRadius(5)
                        .offset(x: 0, y: 40)
                    
                    Button{
                        Task{
                            try await viewModel.signIn(withEmail: email, password: password)
                        }
                    }label: {
                    Text("Sign in")
                        .font(Font.custom("Alatsi", size: 18))
                        .foregroundColor(.white)
                        .disabled(!formisValid)
                        .opacity(formisValid ? 1.0 : 0.5)
                        .padding(.top,80)
                }
                }
                
                HStack{
                    
                    Text("Don’t have an account?")
                        .font(Font.custom("Alatsi", size: 15))
                        .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                    
                    NavigationLink(
                        destination: RegistrationView().navigationBarHidden(true),
                        label: {
                            Text("Sign Up")
                                .font(Font.custom("Alatsi", size: 15))
                                .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                            
                        })
                    
                }.offset(x: 0, y: 100)
                
            }
        }
    }
}
    

//MARK- FORM VALIDATION 
extension LoginView: AuthenticationFormProtocol{
    var formisValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

#Preview {
    LoginView()
}
