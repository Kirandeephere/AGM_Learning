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
                                    .font(Font.custom("Alatsi-Regular", size: 15))
                                    .foregroundColor(Color(hex: 0x14214C))
                            })
                    }
                    .offset(x: -45, y: 0)
                    
                    Text("Forget Password")
                        .font(Font.custom("Alatsi-Regular", size: 25))
                        .foregroundColor(Color(hex: 0x14214C))
                        .offset(x: -20, y: 0)
                    
                }
                .offset(x: 0, y: -60)
                
                //Lock Logo
                ZStack{
                    
                    Image(systemName: "circle.fill")
                        .resizable()
                        .foregroundColor(Color(hex: 0xECECEC))
                        .frame(width: 150, height: 150)
                    Image("lock")
                        .resizable()
                        .frame(width: 120, height: 130)
                    
                }.padding(.bottom, 20)
                
                Text("Please enter the email address to receive \n the password reset link")
                    .font(Font.custom("Alatsi-Regular", size: 15))
                    .foregroundColor(Color(hex: 0x696969))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 60.0)
                
                Text("Email ID")
                    .font(Font.custom("Alatsi-Regular", size: 15))
                    .foregroundColor(Color(hex: 0x696969))
                    .offset(x: -113.50, y: 0)
                
                // Enter Email
                ZStack {
                    Rectangle()
                        .frame(width: 307, height: 38)
                        .foregroundColor(Color(hex: 0xECECEC))
                        .cornerRadius(5)
                    
                    TextField("Enter Your Email Address", text: $email)
                        .font(Font.custom("Alatsi-Regular", size: 15))
                        .offset(x: 65, y: 0)
                        .foregroundColor(Color(hex: 0x808080))
                        .textInputAutocapitalization(.never) //No auto caps text.
                }
                .padding(.top, 5)
                
                // Reset Button
                ZStack {
                    Rectangle()
                        .frame(width: 228, height: 38)
                        .foregroundColor(Color(hex: 0xA92028))
                        .cornerRadius(5)
                        .offset(x: 0, y: 40)
                    
                    NavigationLink(
                        destination: LoginView().navigationBarHidden(true),
                        isActive: $navigateToLogin,
                        label: {
                            Text("Send")
                                .font(Font.custom("Alatsi-Regular", size: 18))
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
                                // Handle error
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
