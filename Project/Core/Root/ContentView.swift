//
//  ContentView.swift
//  Project
//
//  Created by Gursewak Singh on 21/3/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group{
            if viewModel.userSession == nil {
                SplashScreenView()
            } else {
                //SplashScreenView()
                TabView {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }

                    CalenderView()
                        .tabItem {
                            Label("Calender", systemImage: "calendar")
                        }
                    
                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person")
                        }
                }
            }
        }.preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
