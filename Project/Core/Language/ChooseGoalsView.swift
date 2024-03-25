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

    
    var body: some View {

        NavigationView{
            
            VStack() {
                
                //Back Button Arrow
                NavigationLink(destination: EmptyView()) {
                    Image("backarrow")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                .offset(x: -140, y: -20)
                
                
                //Headers - Title, Subtitle
                Text("Choose your goals")
                     .font(Font.custom("Circular Std", size: 30).weight(.bold))
                     .lineSpacing(34)
                     .foregroundColor(Color(red: 0.41, green: 0.42, blue: 0.50))
                     .offset(x: 0, y: -10)

                
                Text("What are your main goals? We will help you \nachieve them!")
                      .font(Font.custom("Rubik", size: 14))
                      .lineSpacing(8)
                      .foregroundColor(Color(red: 0.41, green: 0.42, blue: 0.50))
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
            }) {
                Text("Continue")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 319, height: 60)
                    .background(
                        RoundedRectangle(cornerRadius: 52)
                            .fill(Color(red: 0.6627451, green: 0.1254902, blue: 0.15686275))
                    )
            }
            .padding(.top, 20)
                
                
                //Navigation Link Text
                NavigationLink(
                        destination: EmptyView().navigationBarHidden(true),
                        label: {
                            Text("By using it you confirm that you have read and agree to our terms of service and privacy policy")
                                .font(.custom("Rubik Regular", size: 12))
                                .foregroundColor(Color(red: 0.41, green: 0.42, blue: 0.5))
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
                    .foregroundColor(isSelected ? .green : Color(red: 0.77, green: 0.78, blue: 0.85))
                    .frame(width: 39)
                    .aspectRatio(1, contentMode: .fit)
                    .offset(x: 40, y: 0)

                    
                Spacer()


                
                Text(goal)
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
    ChooseGoalsView()
}
