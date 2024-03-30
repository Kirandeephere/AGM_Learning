//
//  ChooseGoalsView.swift
//  Project
//
//  Created by Gursewak Singh on 25/3/2024.
//

import SwiftUI


struct ChooseGoalsView: View {
    @State private var selectedGoals: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isChooseLevelViewActive = false

    
    var body: some View {

        NavigationView{
            
            VStack() {
                
                //Back Button Arrow
                NavigationLink(destination: ChooseLanguageView().navigationBarHidden(true)) {
                    Image("backarrow")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                .offset(x: -140, y: -20)
                
                
                //Headers - Title, Subtitle
                Text("Choose your goals")
                    .font(Font.custom("Alatsi-Regular", size: 30))
                     .lineSpacing(34)
                     .foregroundColor(Color(hex: 0x686C80))
                     .offset(x: 0, y: -10)

                
                Text("What are your main goals? We will help you \nachieve them!")
                    .font(Font.custom("Alatsi-Regular", size: 14))
                      .lineSpacing(8)
                      .foregroundColor(Color(hex: 0x686C80))
                      .multilineTextAlignment(.center)
                
            
            
            //Languages Box Selection
            GoalsSelectionRow(goal: "Watch Anime", isSelected: selectedGoals == "Watch Anime") {
                            selectedGoals = "Watch Anime"
                       }
                        GoalsSelectionRow(goal: "Learn from Scrach", isSelected: selectedGoals == "Learn from Scrach") {
                           selectedGoals = "Learn from Scrach"
                       }
                        GoalsSelectionRow(goal: "Practice my speaking", isSelected: selectedGoals == "Practice my speaking") {
                           selectedGoals = "Practice my speaking"
                       }
                        GoalsSelectionRow(goal: "Improve my accent", isSelected: selectedGoals == "Improve my accent") {
                            selectedGoals = "Improve my accent"
                        }
                        GoalsSelectionRow(goal: "Sleep Learning", isSelected: selectedGoals == "Sleep Learning") {
                            selectedGoals = "Sleep Learning"
                        }
            
            
            //Continue Button
            Button(action: {
                // Button action
                print("DEBUG: Continue Button Clicked")
                
                // Set the state variable to activate ChooseLevelView
                isChooseLevelViewActive = true
            }) {
                Text("Continue")
                    .font(Font.custom("Alatsi-Regular", size: 20))
                    .foregroundColor(.white)
                    .frame(width: 319, height: 60)
                    .background(
                        RoundedRectangle(cornerRadius: 52)
                            .fill(Color(hex: 0xA92028))
                    )
            }
            .padding(.top, 20)
            .disabled(selectedGoals.isEmpty) // Disable the button if nothing is selected.

            .background(
            // Navigate to ChooseLevelView on clicked button
                    NavigationLink(
                            destination: ChooseLevelView().navigationBarHidden(true),
                            isActive: $isChooseLevelViewActive,
                            label: {
                                        EmptyView()
                                    }
                                )
                        )
                
                
                //Navigation Link Text
                NavigationLink(
                        destination: EmptyView().navigationBarHidden(true),
                        label: {
                            Text("By using it you confirm that you have read and agree to our terms of service and privacy policy")
                                .font(Font.custom("Alatsi-Regular", size: 12))
                                .foregroundColor(Color(hex: 0x686C80))
                        })
                .padding(.top, 20)
                .padding(.horizontal, 40)
            
            }
            
        }

    }
}

//Selection Function
struct GoalsSelectionRow: View {
    let goal: String
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


                
                Text(goal)
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
    ChooseGoalsView()
}
