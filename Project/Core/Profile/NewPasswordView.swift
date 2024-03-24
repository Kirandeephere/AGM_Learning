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
                                        .font(Font.custom("Alatsi", size: 15))
                                        .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                                })
                        }.padding(.leading, -45)
                        
                        
                        
                        Text("Change Password")
                            .font(Font.custom("Alatsi", size: 25))
                            .foregroundColor(Color(red: 0.078, green: 0.13, blue: 0.30))
                            .padding(.leading)
                            
                    }
                    
                    Image("restPass")
                        .resizable()
                        .frame(width: 130, height: 130)
                        .padding(.bottom, 40)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Current Password")
                            .font(Font.custom("Alatsi", size: 15))
                            .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                        
                        SecureField("Enter Your Current Password", text: $currentPassword)
                            .frame(height: 38)
                            .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                            .cornerRadius(5)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("New Password")
                            .font(Font.custom("Alatsi", size: 15))
                            .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                        
                        SecureField("Enter Your New Password", text: $newPassword)
                            .frame(height: 38)
                            .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                            .cornerRadius(5)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Confirm New Password")
                            .font(Font.custom("Alatsi", size: 15))
                            .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                        
                        SecureField("Enter Your Password Again", text: $confirmPassword)
                            .frame(height: 38)
                            .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                            .cornerRadius(5)
                    }
                    
                    
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
                    .font(Font.custom("Alatsi", size: 18))
                    .foregroundColor(.white)
                    .padding()
                    .disabled(!formisValid)
                    .opacity(formisValid ? 1.0 : 0.5)
                    .background(Color(red: 0.66, green: 0.13, blue: 0.16))
                    .cornerRadius(5)
                    
                  

                    
                    // Replace the Group with an alert view
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

enum VolunteerError: Error {
    case wrongCurrentPassword
    // Add other cases as needed
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
