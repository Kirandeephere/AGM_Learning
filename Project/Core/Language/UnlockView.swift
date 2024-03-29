//
//  UnlockView.swift
//  Project
//
//  Created by Gursewak Singh on 25/3/2024.
//

import SwiftUI

struct UnlockView: View {
    var body: some View {
        NavigationView {
            
            //Headers - Title, Back Button
            VStack() {
                
                //Back Button Arrow
                NavigationLink(destination: HomeView().navigationBarHidden(true)) {
                    Image("cross")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                .offset(x: -140, y: -50)
                
                
                //Title
                Text("Speak a new \nlanguage now.")
                    .font(Font.custom("Circular Std", size: 30).weight(.bold))
                    .lineSpacing(14)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.41, green: 0.42, blue: 0.50))
                    .offset(x: 0, y: -20)
                
                
               //Learning Info Stack
                ZStack {
                    Text("Unlock 2.700+ Lessons\nSmart Pronunciation Correction\nFull Sleep Lessons library\n20,000+ Visual Flashcards\nVoices by 90+ Native Speakers\nEverything in fluent Japanese")
                        .font(Font.custom("Circular Std", size: 16).weight(.medium))
                        .lineSpacing(20)
                        .foregroundColor(Color(red: 0.41, green: 0.42, blue: 0.50))
                        .offset(x: 14, y: 0)
                    
                    ForEach(0..<6) { index in
                        Circle()
                            .foregroundColor(.clear)
                            .frame(width: 16, height: 16)
                            .background(Color(red: 0.77, green: 0.78, blue: 0.85))
                            .clipShape(Circle())
                            .offset(x: -123, y: CGFloat(-99 + (index * 39)))
                    }
                }
                .frame(width: 262, height: 240)
                
                
                
                //Try Button
                Button(action: {
                    // Button action
                    print("DEBUG: Try Button Clicked")
                }) {
                    Text("Try it free")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 319, height: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 52)
                                .fill(Color(red: 0.6627451, green: 0.1254902, blue: 0.15686275))
                        )
                }
                .padding(.top, 20)
                
                
                //Normal Text
                Text("3 Days free, then R$ 110,90 per semester. Easily cancel anytime on app store. You won't be charge now.")
                    .font(.custom("Rubik Regular", size: 12))
                    .foregroundColor(Color(red: 0.41, green: 0.42, blue: 0.5))
                    .padding(.top, 20)
                    .padding(.horizontal, 40)
            
            }
        }
    }
}

#Preview {
    UnlockView()
}
