//
//  HomeView.swift
//  Project
//
//  Created by Kirandeep Kaur on 22/3/2024.
//

import SwiftUI
import Firebase

struct HomeView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var searchQuery: String = "" // Track the search query
    @State private var showSearchResults = false // Track if search results view is shown
    
    var body: some View {
        NavigationView {
            if let user = viewModel.currentUser {
                VStack {
                    // Header
                    HStack{
                        HStack {
                            Text(user.initials)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: 60, height: 60)
                                .background(Color(red: 0.71, green: 0.22, blue: 0.25))
                                .clipShape(Circle())
                                
                            
                            
                            VStack(alignment: .leading){
                                Text("Hello,")
                                    .font(Font.custom("Alatsi", size: 20))
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                                    
                                
                                Text(user.fullname)
                                    .font(Font.custom("Alatsi", size: 20))
                                    .fontWeight(.black)
                                    .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                            }
                            
                        }
                        .padding([.leading, .bottom])
                        
                        Spacer()
                        
                        HStack(spacing: 5.0){
                            Text("中")
                                .font(Font.custom("Alatsi", size: 20))
                                .fontWeight(.heavy)
                                .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                            Text("|")
                                .font(Font.custom("Alatsi", size: 20))
                                .fontWeight(.heavy)
                                .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                            Text("Eng")
                                .font(Font.custom("Alatsi", size: 20))
                                .fontWeight(.heavy)
                                .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                            
                        }
                        .padding(.trailing)
                    }
                    
                    // Search Bar
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color(red: 0.93, green: 0.93, blue: 0.93))
                            .frame(width: 307, height: 38)
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(red: 0.50, green: 0.50, blue: 0.50))
                                
                            
                            TextField("Search", text: $searchQuery, onCommit: {
                                showSearchResults = true // Set the state to true when the search is triggered
                            })
                            .font(Font.custom("Alatsi", size: 15))
                            .foregroundColor(Color(red: 0.50, green: 0.50, blue: 0.50))
                            
                        }
                        .padding(.leading, 50)
                    }
                    .padding(.bottom)
                    
                    // Upcomingschedule Cards
                    VStack(alignment: .center) {
                        Text("Upcoming Appointments")
                            .font(Font.custom("Alatsi", size: 20))
                            .foregroundColor(Color(red: 0.51, green: 0.03, blue: 0.06))
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(Color(red: 0.71, green: 0.22, blue: 0.25))
                                .frame(width: 324, height: 160)
                            
                            Text("No upcoming bookings found for the current month.")
                                .frame(width: 300)
                                .multilineTextAlignment(.center)
                                .font(Font.custom("Alatsi", size: 20))
                                .foregroundColor(.white)
                            
                            
                        }
                        
                    }.padding(.bottom)
                    
                    // Main Content
                    Group{
                        
                        HStack {
                            
                            NavigationLink {
                                CourseView().navigationBarHidden(true);
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 18)
                                        .foregroundColor(Color(red: 1, green: 0.96, blue: 0.76))
                                        .frame(width: 153, height: 153)
                                    
                                    VStack {
                                        Image("icon_course")
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                        
                                        Text("Course")
                                            .font(Font.custom("Alatsi", size: 20))
                                            .foregroundColor(.black)
                                    }
                                }
                                .offset(x: -10)
                                
                            }
                            
                            
                            NavigationLink {
                                VolunteerView().navigationBarHidden(true);
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 18)
                                        .foregroundColor(Color(red: 0.94, green: 1, blue: 0.87))
                                        .frame(width: 153, height: 153)
                                    
                                    VStack {
                                        Image("icon_volunteer")
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                        
                                        Text("Volunteer")
                                            .font(Font.custom("Alatsi", size: 20))
                                            .foregroundColor(.black)
                                    }
                                }
                                .offset(x: 10)
                            }
                            
                        }
                        .padding(.bottom, 10)
                        
                        HStack {
                            
                            NavigationLink {
                                ChatBotView().navigationBarHidden(true);
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 18)
                                        .foregroundColor(Color(red: 0.90, green: 1, blue: 0.98))
                                        .frame(width: 153, height: 153)
                                    
                                    VStack {
                                        Image("icon_chatbot")
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                        
                                        Text("AI ChatBot")
                                            .font(Font.custom("Alatsi", size: 20))
                                            .foregroundColor(.black)
                                    }
                                }
                                .offset(x: -10)
                                
                            }
                            
                            NavigationLink {
                                ReviewView().navigationBarHidden(true);
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 18)
                                        .foregroundColor(Color(red: 1, green: 0.91, blue: 0.91))
                                        .frame(width: 153, height: 153)
                                    
                                    VStack {
                                        Image("icon_review")
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                        
                                        Text("Review")
                                            .font(Font.custom("Alatsi", size: 20))
                                            .foregroundColor(.black)
                                    }
                                }
                                .offset(x: 10)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
