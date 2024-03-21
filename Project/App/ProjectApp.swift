//
//  ProjectApp.swift
//  Project
//
//  Created by Gursewak Singh on 21/3/2024.
//

import SwiftUI
import Firebase

@main
struct ProjectApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
