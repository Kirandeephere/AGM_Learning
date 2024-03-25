//
//  VolunteerDetailView.swift
//  Project
//
//  Created by Kirandeep Kaur on 23/3/2024.
//

import SwiftUI

struct VolunteerDetailView: View {
    let volunteer: Volunteer // Assuming you have a Volunteer struct/model

    var body: some View {
        VStack(alignment: .center) {
            // Header
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.clear)
                        .frame(width: 40, height: 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )

                    NavigationLink(
                        destination: VolunteerView().navigationBarHidden(true),
                        label: {
                            Image(systemName: "chevron.backward")
                                .font(Font.custom("Alatsi", size: 15))
                                .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                        })
                }
                

                Text(volunteer.Name + "  #" + volunteer.ID)
                    .font(Font.custom("Alatsi", size: 25))
                    .foregroundColor(Color(red: 0.078, green: 0.13, blue: 0.30))
                    
                
            }
            Spacer()
            // Person Image
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 300, height: 300)
                .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                .padding(.vertical)
            
            Divider()
            
            VStack(alignment: .leading){
                
                Text(volunteer.University)
                    .font(Font.custom("Alatsi", size: 15))
                    .foregroundColor(.black)
                    .padding(.bottom,5)
                
                Text("Majoring in \(volunteer.Major)")
                    .font(Font.custom("Alatsi", size: 15))
                    .foregroundColor(.black)
                
                Text("About:")
                      .font(Font.custom("Alatsi", size: 18))
                      .foregroundColor(.black)
                      .padding(.top)
                
                Text(volunteer.About)
                      .font(Font.custom("Alatsi", size: 15))
                      .foregroundColor(.black)
                      
            }
            
            
            Spacer()
            
            // Book Button
            NavigationLink(destination: BookingView(name: volunteer.Name, subject: volunteer.Major)) {
                Text("Book")
                    .font(Font.custom("Alatsi", size: 20))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }

        }
        .padding()
        .navigationBarHidden(true)
    }
}


