//
//  ChooseLevelView.swift
//  Project
//
//  Created by Gursewak Singh on 25/3/2024.
//

import SwiftUI

struct ChooseLevelView: View {
    @State private var selectedLevel: String = ""
    @State private var isChooseLevelViewActive = false


    var body: some View {
        NavigationView {
            
            //Headers - Title, Back Button
            VStack() {
                
                //Back Button Arrow
                NavigationLink(destination: ChooseGoalsView().navigationBarHidden(true)) {
                    Image("backarrow")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                .offset(x: -140, y: -50)
                
                
                //Title
                Text("What's your level?")
                    .font(Font.custom("Alatsi-Regular", size: 30))
                     .lineSpacing(34)
                     .foregroundColor(Color(hex: 0x686C80))
                     .offset(x: 0, y: -40)

                
                Text("Choose your current level. We will \nsuggest the best lessons for you")
                    .font(Font.custom("Alatsi-Regular", size: 14))
                      .lineSpacing(8)
                      .foregroundColor(Color(hex: 0x686C80))
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
            
            
            
            //IDK Button
            Button(action: {
                // Button action
                print("DEBUG: IDK Button Clicked")
                
                // Set the state variable to activate ChooseLevelView
                isChooseLevelViewActive = true
            }) {
                Text("I don't know")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 319, height: 60)
                    .background(
                        RoundedRectangle(cornerRadius: 52)
                            .fill(Color(hex: 0xA92028))
                    )
            }
            .padding(.top, 20)
            .disabled(selectedLevel.isEmpty) // Disable the button if nothing is selected
            .background(
            // Navigate to PrepareView on clicked button
                    NavigationLink(
                            destination: PrepareView().navigationBarHidden(true),
                            isActive: $isChooseLevelViewActive,
                            label: {
                                        EmptyView()
                                    }
                                )
                        )
            
            }
            .padding(.horizontal, 20)
                
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
                    .foregroundColor(isSelected ? .green : Color(hex: 0xC5C8D8))
                    .frame(width: 39)
                    .aspectRatio(1, contentMode: .fit)
                    .offset(x: 40, y: 0)

                    
                Spacer()

                
                Text(level)
                    .font(Font.custom("Alatsi-Regular", size: 20))
                    .lineSpacing(34)
                    .foregroundColor(isSelected ? .green : Color(hex: 0x686C80))
                    .padding(.leading, 10)

                Spacer()

            }
            .frame(width: 325, height: 67)
            .background(Color(hex: 0xEEF0F7))
            .cornerRadius(10)
            .padding(.top, 10)
        }
        .padding(.top, 10)
    }
}

#Preview {
    ChooseLevelView()
}
