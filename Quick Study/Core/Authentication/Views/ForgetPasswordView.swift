//
//  ForgetPasswordView.swift
//  Project
//
//  Created by Gursewak Singh on 21/3/2024.
//

import SwiftUI
import Firebase

//struct ForgetPasswordView: View {
//    @State private var email: String = ""
//    @State private var errorMessage: String = ""
//    @State private var successMessage: String = ""
//    @State private var navigateToLogin = false
//
//    @EnvironmentObject var viewModel : AuthViewModel
//    
//    var body: some View {
//        NavigationView{
//            VStack{
//                
//                //Header Starts
//                HStack{
//                    ZStack{
//                        RoundedRectangle(cornerRadius: 10)
//                            .foregroundColor(.clear)
//                            .frame(width: 40, height: 40)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(Color.black, lineWidth: 1)
//                            )
//                        
//                        NavigationLink(
//                            destination: LoginView().navigationBarHidden(true),
//                            label: {
//                                Image(systemName: "chevron.backward")
//                                    .font(Font.custom("Alatsi-Regular", size: 15))
//                                    .foregroundColor(Color(hex: 0x14214C))
//                            })
//                    }
//                    .offset(x: -45, y: 0)
//                    
//                    Text("Forget Password")
//                        .font(Font.custom("Alatsi-Regular", size: 25))
//                        .foregroundColor(Color(hex: 0x14214C))
//                        .offset(x: -20, y: 0)
//                    
//                }
//                .offset(x: 0, y: -60)
//                
//                //Lock Logo
//                ZStack{
//                    
//                    Image(systemName: "circle.fill")
//                        .resizable()
//                        .foregroundColor(Color(hex: 0xECECEC))
//                        .frame(width: 150, height: 150)
//                    Image("lock")
//                        .resizable()
//                        .frame(width: 120, height: 130)
//                    
//                }.padding(.bottom, 20)
//                
//                Text("Please enter the email address to receive \n the password reset link")
//                    .font(Font.custom("Alatsi-Regular", size: 15))
//                    .foregroundColor(Color(hex: 0x696969))
//                    .multilineTextAlignment(.center)
//                    .padding(.bottom, 60.0)
//                
//                Text("Email ID")
//                    .font(Font.custom("Alatsi-Regular", size: 15))
//                    .foregroundColor(Color(hex: 0x696969))
//                    .offset(x: -113.50, y: 0)
//                
//                // Enter Email
//                ZStack {
//                    Rectangle()
//                        .frame(width: 307, height: 38)
//                        .foregroundColor(Color(hex: 0xECECEC))
//                        .cornerRadius(5)
//                    
//                    TextField("Enter Your Email Address", text: $email)
//                        .font(Font.custom("Alatsi-Regular", size: 15))
//                        .offset(x: 65, y: 0)
//                        .foregroundColor(Color(hex: 0x808080))
//                        .textInputAutocapitalization(.never) //No auto caps text.
//                }
//                .padding(.top, 5)
//                
//                // Reset Button
//                ZStack {
//                    Rectangle()
//                        .frame(width: 228, height: 38)
//                        .foregroundColor(Color(hex: 0xA92028))
//                        .cornerRadius(5)
//                        .offset(x: 0, y: 40)
//                    
//                    NavigationLink(
//                        destination: LoginView().navigationBarHidden(true),
//                        isActive: $navigateToLogin,
//                        label: {
//                            Text("Send")
//                                .font(Font.custom("Alatsi-Regular", size: 18))
//                                .foregroundColor(.white)
//                                .disabled(!formisValid)
//                                .opacity(formisValid ? 1.0 : 0.5)
//                                .padding(.top, 80)
//                        }).onTapGesture {
//                            Task {
//                                print("SEND BUTTON CLICKED")
//                                do {
//                                    print("Sending password reset email for email:", email)
//                                    try await viewModel.resetPassword(forEmail: email)
//                                    successMessage = "Password reset email sent successfully"
//                                    navigateToLogin = true
//                                } catch {
//                                    print("Error occurred while sending password reset email:", error.localizedDescription)
//                                    errorMessage = error.localizedDescription
//                                }
//                            }
//                        }
//                    
//                    // Group for error and success messages...
//                    Group {
//                        if !errorMessage.isEmpty {
//                            Text(errorMessage)
//                                .foregroundColor(.red)
//                                .padding()
//                        }
//                        
//                        if !successMessage.isEmpty {
//                            Text(successMessage)
//                                .foregroundColor(.green)
//                                .padding()
//                        }
//                    }
//                    
//                }
//                .task {
//                    await viewModel.fetchUser()
//                    
//                }
//            }
//        }
//    }
//}
        
struct ForgetPasswordView: View {
    @State private var email: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showLoginView = false

    var body: some View {
        VStack(alignment: .leading) {
            
            //header
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
                }.padding(.trailing)
                
                Text("Forget Password")
                    .font(Font.custom("Alatsi-Regular", size: 25))
                    .foregroundColor(Color(hex: 0x14214C))
                    .padding(.leading)
                    
                
            }.padding(.bottom, 80)
        

            //Lock Logo
            HStack{
                Spacer()
                ZStack{
                    Image(systemName: "circle.fill")
                        .resizable()
                        .foregroundColor(Color(hex: 0xECECEC))
                        .frame(width: 150, height: 150)
                    Image("lock")
                        .resizable()
                        .frame(width: 120, height: 130)

                }.padding(.bottom, 20)
                Spacer()
            }
            
            //Text
            HStack{
                Spacer()
                Text("Please enter the email address to receive \n the password reset link")
                    .font(Font.custom("Alatsi-Regular", size: 15))
                    .foregroundColor(Color(hex: 0x696969))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 60.0)
                Spacer()
            }
           
            //Enter Email
            VStack(alignment: .leading){
                Text("Email ID")
                    .font(Font.custom("Alatsi-Regular", size: 15))
                    .foregroundColor(Color(hex: 0x696969))
                    .padding(.leading, 30)
                    
                // Enter Email
                ZStack{
                    Rectangle()
                        .frame(width: 307, height: 38)
                        .foregroundColor(Color(hex: 0xECECEC))
                        .cornerRadius(5)

                    TextField("Enter Your Email Address", text: $email)
                        .font(Font.custom("Alatsi-Regular", size: 15))
                        .padding(.leading,40)
                        .foregroundColor(Color(hex: 0x808080))
                        .textInputAutocapitalization(.never) //No auto caps text.
                }
                .padding(.top, 5)
                
            }.padding(.bottom)
            
            //Reset Button
            HStack{
                Spacer()
                Button(action: resetPassword) {
                    Text("Reset Password")
                        .foregroundColor(.white)
                        .font(Font.custom("Alatsi-Regular", size: 18))
                        .padding()
                        .cornerRadius(10)
                        .frame(width: 228, height: 38)
                        .background(Color(hex: 0xA92028))
                        .cornerRadius(5)
                        
                }
                
                Spacer()
            }
            
            Spacer()
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Reset Password"), message: Text(alertMessage), dismissButton: .default(Text("OK"), action: {
                if(alertMessage == "Password reset email sent!"){
                    showLoginView = true
                }
                else{
                    showLoginView = false
                }
                
            })
            )
        }.background(
            NavigationLink(
                destination: LoginView().navigationBarHidden(true),
                isActive: $showLoginView,
                label: { EmptyView() }
            )
        )
    }
    
    func resetPassword() {
        print("Resetting password for email: \(email)")
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                // Handle error
                print("Error resetting password: \(error.localizedDescription)")
                alertMessage = error.localizedDescription
            } else {
                // Reset password email sent successfully
                print("Password reset email sent to: \(email)")
                alertMessage = "Password reset email sent!"
                
            }
            
            showAlert = true
        }
    }
}

#Preview {
    ForgetPasswordView()
}
