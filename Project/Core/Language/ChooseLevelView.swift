//
//  ChooseLevelView.swift
//  Project
//
//  Created by Gursewak Singh on 25/3/2024.
//

import SwiftUI

struct ChooseLevelView: View {
    @State private var selectedLevel: String = ""

    var body: some View {
        NavigationView {
            
            
            //Headers - Title, Back Button
            VStack() {
                
                //Back Button Arrow
                NavigationLink(destination: EmptyView()) {
                    Image("backarrow")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                .offset(x: -140, y: -50)
                
                
                //Title
                Text("What's your level?")
                     .font(Font.custom("Circular Std", size: 30).weight(.bold))
                     .lineSpacing(34)
                     .foregroundColor(Color(red: 0.41, green: 0.42, blue: 0.50))
                     .offset(x: 0, y: -40)

                
                Text("Choose your current level. We will \nsuggest the best lessons for you")
                      .font(Font.custom("Rubik", size: 14))
                      .lineSpacing(8)
                      .foregroundColor(Color(red: 0.41, green: 0.42, blue: 0.50))
                      .multilineTextAlignment(.center)
            
            
            //Level Box Selection
            LevelSelectionRow(level: "I'm just starting", isSelected: selectedLevel == "I'm just starting") {
                        selectedLevel = "I'm just starting"
                       }
                        LevelSelectionRow(level: "I know the basics", isSelected: selectedLevel == "I know the basics") {
                           selectedLevel = "I know the basics"
                       }
                        LevelSelectionRow(level: "I know a lot", isSelected: selectedLevel == "I know a lot") {
                           selectedLevel = "I know a lot"
                       }
                        LevelSelectionRow(level: "I'm Samurai", isSelected: selectedLevel == "I'm Samurai") {
                            selectedLevel = "I'm Samurai"
                }
                   }
                   .padding(.horizontal, 20)
            
            
            //IDK Button
            Button(action: {
                // Button action
                print("DEBUG: IDK Button Clicked")
            }) {
                Text("I dont know")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 319, height: 60)
                    .background(
                        RoundedRectangle(cornerRadius: 52)
                            .fill(Color(red: 0.6627451, green: 0.1254902, blue: 0.15686275))
                    )
            }
            .padding(.top, 20)
        }
        
    }
}

//Selection Function
struct LevelSelectionRow: View {
    let level: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                
                Circle()
                    .foregroundColor(isSelected ? .green : Color(red: 0.77, green: 0.78, blue: 0.85))
                    .frame(width: 39)
                    .aspectRatio(1, contentMode: .fit)
                    .offset(x: 40, y: 0)

                    
                Spacer()

                
                Text(level)
                    .font(Font.custom("Circular Std", size: 20).weight(.medium))
                    .lineSpacing(34)
                    .foregroundColor(isSelected ? .green : Color(red: 0.41, green: 0.42, blue: 0.50))
                    .padding(.leading, 10)

                Spacer()

            }
            .frame(width: 325, height: 67)
            .background(Color(red: 0.93, green: 0.94, blue: 0.97))
            .cornerRadius(10)
            .padding(.top, 10)
        }
        .padding(.top, 10)
    }
}

#Preview {
    ChooseLevelView()
}
