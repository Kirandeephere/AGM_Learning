//
//  LessonView.swift
//  Project
//
//  Created by Gursewak Singh on 28/3/2024.
//

import SwiftUI

struct LessonView: View {
    @State private var taskInput: String = "Testing Dummy Data"

    var body: some View {
        NavigationView{
            
            VStack() {
                
                //Back Button Arrow
                NavigationLink(destination: EmptyView()) {
                    Image("backarrow")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                .offset(x: -140, y: -80)
                
                
                //Headers - Title, Subtitle
                Text("Start Lesson 1")
                     .font(Font.custom("Circular Std", size: 30).weight(.bold))
                     .lineSpacing(34)
                     .foregroundColor(Color(red: 0.41, green: 0.42, blue: 0.50))
                     .offset(x: 0, y: -60)

                //Ellipse
                Ellipse()
                    .foregroundColor(Color(red: 0.77, green: 0.78, blue: 0.85))
                    .frame(width: 108.33, height: 131.88)
                    .padding(.bottom, 60)
                
                //Text
                Text("Have you learn your \nfirst letters")
                      .font(Font.custom("Rubik", size: 14))
                      .lineSpacing(8)
                      .foregroundColor(Color(red: 0.41, green: 0.42, blue: 0.50))
                      .multilineTextAlignment(.center)
                      .padding(.bottom, 50)
        
                //Stack for the Goal input
                ZStack() {
    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 102.92, height: 36.92)
                        .background(Color(red: 0.87, green: 0.89, blue: 0.96))
                        .cornerRadius(33)
                        .offset(x: -4.33, y: -23.74)
                    
                    
                      TextField("Enter Task", text: $taskInput)
                                .font(Font.custom("Circular Std", size: 20).weight(.medium))
                                .foregroundColor(Color(red: 0.41, green: 0.42, blue: 0.50))
                                .padding(.horizontal, 20)
                                .frame(width: 323.92, height: 65.94)
                    .background(
                               RoundedRectangle(cornerRadius: 33)
                                .foregroundColor(.clear)
                                .overlay(
                                RoundedRectangle(cornerRadius: 33)
                                 .inset(by: 1)
                                 .stroke(Color(red: 0.87, green: 0.89, blue: 0.96), lineWidth: 1)
                                    )
                        )
                         .offset(x: 0, y: 9.23)
                    
                    Text("Your Goal")
                      .font(Font.custom("Rubik", size: 12).weight(.medium))
                      .lineSpacing(24)
                      .foregroundColor(Color(red: 0.41, green: 0.42, blue: 0.50))
                      .offset(x: -4.33, y: -23.74)

                }
                .frame(width: 323.92, height: 84.40)
                
                
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
                
                Spacer()

            }
            .offset(x:0, y : 100)
        }
    }
}

#Preview {
    LessonView()
}
