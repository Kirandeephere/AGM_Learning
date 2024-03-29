//
//  PrepareView.swift
//  Project
//
//  Created by Gursewak Singh on 25/3/2024.
//

import SwiftUI

struct PrepareView: View {
    @State private var progress: CGFloat = 0.0
    private let totalWidth: CGFloat = 314 // Total width of the loading bar
    private let animationDuration: Double = 4.0 // Animation duration in seconds
    @State private var navigateToUnlockView = false

    var body: some View {
        NavigationView {
            VStack {
                // Back Button Arrow
//                NavigationLink(destination: EmptyView()) {
//                    Image("backarrow")
//                        .font(.title)
//                        .foregroundColor(.blue)
//                }
//                .offset(x: -140, y: 50)

                // Header
                HStack {
                    Text("Preparing your\nSuuuper Course!")
                        .font(Font.custom("Circular Std", size: 30).weight(.medium))
                        .lineSpacing(14)
                        .foregroundColor(Color(red: 0.41, green: 0.42, blue: 0.50))
                }
                .offset(x: 0, y: 250)

                Spacer()

                // Loading Bar
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(red: 0.9333333373069763, green: 0.9411764740943909, blue: 0.9686274528503418))
                        .frame(width: totalWidth, height: 12)

                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.blue)
                        .frame(width: progress * totalWidth, height: 12)
                        .animation(.linear(duration: animationDuration)) // Set animation duration
                }
                .offset(x: 0, y: -320)
            }
            .onAppear {
                // Simulate loading progress
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    progress = 1.0 // Set the progress value to 1 (complete)
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                        // Navigate to the UnlockView after the animation duration
                        navigateToUnlockView = true
                    }
                }
            }
            .background(
                NavigationLink(
                    destination: UnlockView().navigationBarHidden(true),
                    isActive: $navigateToUnlockView) 
                {
                    EmptyView()
                }
            )
            
            
        }
    }
}


#Preview {
    PrepareView()
}
