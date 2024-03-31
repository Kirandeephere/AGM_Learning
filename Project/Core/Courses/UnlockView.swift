//
//  UnlockView.swift
//  Project
//
//  Created by Gursewak Singh on 25/3/2024.
//

import SwiftUI

struct UnlockView: View {
    @State private var isHiraganaStartViewActive = false
    
    var body: some View {
            
            //Headers - Title, Back Button
            VStack() {
                
                //Back Button Arrow
                NavigationLink(destination: HomeView().navigationBarHidden(true)) {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width:20, height: 20)
                        .font(.title.bold())
                        .foregroundColor(.black)
                        
                }
                .offset(x: -140, y: -50)
                
                
                //Title
                Text("Speak a new \nlanguage now.")
                    .font(Font.custom("Alatsi-Regular", size: 30))
                    .lineSpacing(14)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(hex: 0x686C80))
                    .offset(x: 0, y: -20)
                
                
               //Learning Info Stack
                ZStack {
                    Text("Unlock 2.700+ Lessons\nSmart Pronunciation Correction\nFull Sleep Lessons library\n20,000+ Visual Flashcards\nVoices by 90+ Native Speakers\nEverything in fluent Japanese")
                        .font(Font.custom("Alatsi-Regular", size: 16))
                        .lineSpacing(20)
                        .foregroundColor(Color(hex: 0x686C80))
                        .offset(x: 14, y: 0)
                    
                    ForEach(0..<6) { index in
                        Circle()
                            .foregroundColor(Color(hex: 0xC5C8D8))
                            .frame(width: 16, height: 16)
                            .clipShape(Circle())
                            .offset(x: -123, y: CGFloat(-99 + (index * 39)))
                    }
                }
                .frame(width: 262, height: 240)
                
                //Try Button
                Button(action: {
                    // Button action
                    print("DEBUG: Try Button Clicked")
                    
                    isHiraganaStartViewActive = true
                }) {
                    Text("Try it free")
                        .font(Font.custom("Alatsi-Regular", size: 20))
                        .foregroundColor(.white)
                        .frame(width: 319, height: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 52)
                                .fill(Color(hex: 0xA92028))
                        )
                }
                .padding(.top, 20)
                .background(
                // Navigate to ChooseLevelView on clicked button
                        NavigationLink(
                                destination: HiraganaStartView().navigationBarHidden(true),
                                isActive: $isHiraganaStartViewActive,
                                label: {
                                            EmptyView()
                                        }
                                    )
                            )
                
                
                //Normal Text
                HStack {
                    Text("3 Days free, then R$ 110,90 per semester. ")
                        .font(Font.custom("Alatsi-Regular", size: 12))
                        .foregroundColor(Color(hex: 0x000000))

                    +
                    Text("Easily cancel anytime on app store. You won't be charge now.")
                        .font(Font.custom("Alatsi-Regular", size: 12))
                        .foregroundColor(Color(hex: 0x686C80))
                }
                .padding(.top, 20)
                .padding(.horizontal, 40)
                .multilineTextAlignment(.center)

            
            }
    }
}

#Preview {
    UnlockView()
}
