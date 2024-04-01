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
            HStack{
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
                .offset(x: -20, y: 0)
                

                Text(volunteer.Name + " #" + volunteer.ID)
                    .font(Font.custom("Alatsi", size: 25))
                    .foregroundColor(Color(red: 0.078, green: 0.13, blue: 0.30))
            }
            Spacer()
            
            // Person Image
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 300, height: 300)
                .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                .padding(.vertical , 20)
            
            
            Divider()
            
            VStack(alignment: .leading){
                
                Text(volunteer.Name + " #" + volunteer.ID)
                    .font(Font.custom("Alatsi", size: 25).bold())
                    .foregroundColor(Color(red: 0.078, green: 0.13, blue: 0.30))
                    .padding(.bottom,5)
                    .padding(.leading, 15)

                
                Text(volunteer.University)
                    .font(Font.custom("Alatsi", size: 15).bold())
                    .foregroundColor(.black)
                    .padding(.bottom,5)
                    .padding(.leading, 15)

                
                Text("Majoring in \(volunteer.Major)")
                    .font(Font.custom("Alatsi", size: 15).bold())
                    .foregroundColor(.black)
                    .padding(.leading, 15)

                
                Text("About:")
                      .font(Font.custom("Alatsi", size: 18).bold())
                      .foregroundColor(.black)
                      .padding(.top, 15)
                      .padding(.leading, 15)
                      .padding(.trailing, 15)


                
                Text(volunteer.About)
                      .font(Font.custom("Alatsi", size: 15))
                      .foregroundColor(.black)
                      .padding(.top, 10)
                      .padding(.leading, 15)
                      .padding(.trailing, 15)
                      .multilineTextAlignment(.leading)

                      
            }
            
            
            Spacer()
            
            // Book Button
            NavigationLink(destination: BookingView(name: volunteer.Name, subject: volunteer.Major).navigationBarBackButtonHidden(true)){
                Text("Book Session")
                    .font(Font.custom("Alatsi-Regular", size: 20))
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 319, height: 60)
                    .background(
                        RoundedRectangle(cornerRadius: 52)
                            .fill(Color(hex: 0xA92028))
                    )            }

        }
        .padding()
        .navigationBarHidden(true)
    }
}


struct VolunteerDetailView_Previews: PreviewProvider {
    static var previews: some View {
            VolunteerDetailView(volunteer: dummyVolunteer())
            //Instead of dummyVolunteer() use Volunteer() for actual use case
    }

    //Added Dummy data for testing only.
    static func dummyVolunteer() -> Volunteer {
        let volunteer = Volunteer()
        volunteer.ID = "2319"
        volunteer.Name = "Chan Tai Man "
        volunteer.University = "The Hong Kong Polytechnic University (PolyU)"
        volunteer.Major = "Major in Social Work"
        volunteer.About = "I am a year 3 student studying in The Hong Kong Polytechnic University (PolyU). I am a very outgoing person, and I love to meet new people. Thank you for taking the time to get to know me. I hope to see you all soon!"
        return volunteer
    }
}



