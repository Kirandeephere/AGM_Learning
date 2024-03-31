//
//  NewPasswordView.swift
//  Project
//
//  Created by Gursewak Singh on 22/3/2024.
//
import SwiftUI
import FirebaseAuth

struct NewPasswordView: View {
        @State private var currentPassword: String = ""
        @State private var newPassword: String = ""
        @State private var confirmPassword: String = ""
        @State private var alertMessage: String = ""
        @State private var showAlert = false
        
        @AppStorage("isUserAuthenticated") private var isUserAuthenticated = false
        @EnvironmentObject var viewModel: AuthViewModel
        
        var body: some View {
            NavigationView {
                VStack(spacing: 40) {
                    
                    
                    HStack {
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
                                        .font(Font.custom("Alatsi-Regular", size: 15))
                                        .foregroundColor(Color(hex: 0x14214C))
                                })
                        }.padding(.leading, -45)
                        
                        
                        
                        Text("Change Password")
                            .font(Font.custom("Alatsi-Regular", size: 25))
                            .foregroundColor(Color(hex: 0x14214C))
                            .padding(.leading)
                            
                    }
                    .padding(.bottom, 50)

                    
                    Image("restPass")
                        .resizable()
                        .frame(width: 130, height: 130)
                        .offset(x:0, y: -50)
                    
                   
                    
                    ZStack {
                        Text("Current Password")
                            .font(Font.custom("Alatsi-Regular", size: 15))
                            .foregroundColor(Color(hex: 0x737373))
                            .offset(x: -75, y: -40)
                        
                        Rectangle()
                            .frame(width: 307, height: 38)
                            .foregroundColor(Color(hex: 0xECECEC))
                            .cornerRadius(5)
                        
                        SecureField("Enter Your Current Password", text: $currentPassword)
                            .offset(x: 55, y: 0)
                            .foregroundColor(Color(hex: 0x808080))
                        
                    }
                    .padding(.bottom, 15)
                    
                
                    
                    ZStack {
                        Text("New Password")
                            .font(Font.custom("Alatsi-Regular", size: 15))
                            .foregroundColor(Color(hex: 0x737373))
                            .offset(x: -75, y: -40)
                        
                        Rectangle()
                            .frame(width: 307, height: 38)
                            .foregroundColor(Color(hex: 0xECECEC))
                            .cornerRadius(5)
                        
                        SecureField("Enter Your New Password", text: $newPassword)
                            .offset(x: 55, y: 0)
                            .foregroundColor(Color(hex: 0x808080))
                        
                    }
                    .padding(.bottom, 15)
                    
                    
                    ZStack {
                        Text("Confirm New Password")
                            .font(Font.custom("Alatsi-Regular", size: 15))
                            .foregroundColor(Color(hex: 0x737373))
                            .offset(x: -45, y: -40)
                        
                        Rectangle()
                            .frame(width: 307, height: 38)
                            .foregroundColor(Color(hex: 0xECECEC))
                            .cornerRadius(5)
                        
                        SecureField("Enter Your Password Again", text: $confirmPassword)
                            .offset(x: 55, y: 0)
                            .foregroundColor(Color(hex: 0x808080))
                        
                    }
                    .padding(.bottom, 15)
                    
      
                   
                    //Submit Button
                    Button("Submit") {
                        Task {
                            do {
                                guard formisValid else {
                                    alertMessage = "Please enter valid passwords"
                                    showAlert = true
                                    return
                                }

                                try await viewModel.updatePassword(newPassword: newPassword, currentPassword: currentPassword) { error in
                                    if let error = error {
                                        print("Current password doesnt match!")
                                        alertMessage = "Current password doesnt match!"
                                    } else {
                                        print("Password updated successfully!")
                                        alertMessage = "Password updated successfully!"
                                        try? viewModel.signOut()
                                        isUserAuthenticated = false
                                    }
                                    showAlert = true
                                }
                            } catch {
                                print("Error: \(error)")
                                alertMessage = "Error: \(error.localizedDescription)"
                                showAlert = true
                            }
                        }
                    }
                    .font(Font.custom("Alatsi-Regular", size: 18))
                    .frame(width: 228, height: 38)
                    .foregroundColor(.white)
                    .disabled(!formisValid)
                    .opacity(formisValid ? 1.0 : 0.5)
                    .background(Color(hex: 0xA92028))
                    .cornerRadius(5)
                    
                    // Alert view
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text(alertMessage),
                            message: nil,
                            dismissButton: .default(Text("OK"))
                        )
                    }

                    
                }
                .padding()
            }
        }
    }


//MARK- FORM VALIDATION
extension NewPasswordView: AuthenticationFormProtocol{
    var formisValid: Bool {
        return !currentPassword.isEmpty
        && !newPassword.isEmpty
        && currentPassword.count > 5
        && newPassword.count > 5
        && newPassword == confirmPassword
    }
}

#Preview {
    NewPasswordView()
}
