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
                        Button(action: {
                            // Handle back navigation
                        }) {
                            Image(systemName: "chevron.backward")
                                .font(Font.custom("Alatsi", size: 15))
                                .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                        }
                        .frame(width: 40, height: 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .padding(.leading, -45)
                        
                        Text("Change Password")
                            .font(Font.custom("Alatsi", size: 25))
                            .foregroundColor(Color(red: 0.078, green: 0.13, blue: 0.30))
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
                    
                    Button("Submit") {
                        Task {
                            do {
                                try await viewModel.updatePassword(newPassword: newPassword, currentPassword: currentPassword) { error in
                                    if let error = error {
                                        alertMessage = "Failed to update password: \(error.localizedDescription)"
                                    } else {
                                        alertMessage = "Password updated successfully!"
                                        try? Auth.auth().signOut()
                                        isUserAuthenticated = false
                                    }
                                    showAlert = true
                                }
                            } catch {
                                alertMessage = "Error: \(error.localizedDescription)"
                                showAlert = true
                            }
                        }
                    }
                    .font(Font.custom("Alatsi", size: 18))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(red: 0.66, green: 0.13, blue: 0.16))
                    .cornerRadius(5)
                    
                    Group {
                        if !alertMessage.isEmpty {
                            Text(alertMessage)
                                .foregroundColor(alertMessage == "Password updated successfully!" ? .green : .red)
                                .padding()
                        }
                    }
                    
                }
                .padding()
            }
        }
    }

#Preview {
    NewPasswordView()
}
