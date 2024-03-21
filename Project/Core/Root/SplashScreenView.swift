//
//  SplashScreenView.swift
//  Learning
//
//  Created by Gursewak Singh on 20/3/2024.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    
    var body: some View {
        if isActive{
            LoginView()
        }else {
            VStack {
                VStack {
                    Spacer() // Add a spacer above the image to push it to the center vertically
                    
                    Image("splashlogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 313, height: 98) // Make the image fill the available space
                        .foregroundColor(.red)
                    
                    Spacer()
                    // Add a spacer below the image to push it to the center vertically
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    withAnimation{
                        self.isActive = true
                    }
                }
            }
            
        }
        
    }
}


#Preview {
    SplashScreenView()
}
