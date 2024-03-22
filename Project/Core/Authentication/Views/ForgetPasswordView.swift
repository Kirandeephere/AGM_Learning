//
//  ForgetPasswordView.swift
//  Project
//
//  Created by Gursewak Singh on 21/3/2024.
//

import SwiftUI

struct ForgetPasswordView: View {
    @State private var email: String = ""
    @State private var errorMessage: String = ""
    @State private var successMessage: String = ""
    @State private var navigateToLogin = false

    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        NavigationView{
            VStack{
                
                //Header Starts
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
                    
                    Text("Forget Password")
                        .font(Font.custom("Alatsi", size: 25))
                        .foregroundColor(Color(red: 0.078, green: 0.13, blue: 0.30))
                        .offset(x: -20, y: 0)
                    
                }
                .offset(x: 0, y: -100)
                
                //Lock Logo
                ZStack{
                    
                    Image(systemName: "circle.fill")
                        .resizable()
                        .foregroundColor(Color(red: 0.93, green: 0.93, blue: 0.93, opacity: 1.0))
                        .frame(width: 150, height: 150)
                    Image("lock")
                        .resizable()
                        .frame(width: 70, height: 75)
                    
                }.padding(.bottom)
                
                Text("Please enter the email address to receive \n the password reset link")
                    .font(Font.custom("Alatsi", size: 15))
                    .foregroundColor(Color(red: 0.41, green: 0.41, blue: 0.41))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 23.0)
                
                Text("Email Address")
                    .font(Font.custom("Alatsi", size: 15))
                    .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                    .offset(x: -113.50, y: 0)
                
                // Enter Email
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 307, height: 38)
                        .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                        .cornerRadius(5)
                    
                    TextField("Enter Your Email Address", text: $email)
                        .offset(x: 65, y: 0)
                        .textInputAutocapitalization(.never) //No auto caps text. 
                }
                
                // Reset Button
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 228, height: 38)
                        .background(Color(red: 0.66, green: 0.13, blue: 0.16))
                        .cornerRadius(5)
                        .offset(x: 0, y: 40)
                    
                    NavigationLink(
                        destination: LoginView().navigationBarHidden(true),
                        isActive: $navigateToLogin,
                        label: {
                            Text("Send")
                                .font(Font.custom("Alatsi", size: 18))
                                .foregroundColor(.white)
                                .disabled(!formisValid)
                                .opacity(formisValid ? 1.0 : 0.5)
                                .padding(.top, 80)
                        })
                    .onTapGesture {
                        Task {
                            do{
                                try await viewModel.resetPassword(forEmail: email)
                                successMessage = "Password reset email sent successfully"
                                navigateToLogin = true
                            }catch {
                                errorMessage = error.localizedDescription
                            }
                        }
                    }
                    
                    // Group for error and success messages...
                    Group {
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
                .task {
                    await viewModel.fetchUser()
                    
                }
            }
        }
        
    }
}
        

//MARK- FORM VALIDATION
extension ForgetPasswordView: AuthenticationFormProtocol{
    var formisValid: Bool {
        return !email.isEmpty
        && email.contains("@")
    }
}


#Preview {
    ForgetPasswordView()
}
