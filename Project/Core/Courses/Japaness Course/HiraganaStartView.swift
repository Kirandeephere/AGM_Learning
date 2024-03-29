//
//  HiraganaStartView.swift
//  Project
//
//  Created by Gursewak Singh on 28/3/2024.
//

import SwiftUI

struct HiraganaStartView: View {
    var body: some View {
        
        ZStack(){
            // Background color for testing area section
            //Color(.green)
            
            //Gray Square
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 43, height: 36)
              .background(Color(red: 0.93, green: 0.94, blue: 0.97))
              .cornerRadius(4)
              .offset(x: -150, y: 0)
        }
        .frame(width: 353, height: 50)
        .padding(.top, 30)
        .padding(.bottom, 30)
        
        //Scorable Middle Section
        ScrollView {
            ZStack() {
                // Background color for testing area section
                //Color(.lightGray)
                
                //Hiragana Big Box Area
                Group {
                    //Background Square
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 353, height: 158)
                        .background(Color(red: 0.93, green: 0.94, blue: 0.97))
                        .cornerRadius(7)
                        .padding(.horizontal, 20)
                        .offset(x: 0, y: -167.50)
                    
                    //Title
                    Text("Hiragana")
                        .font(Font.custom("Circular Std", size: 20).weight(.bold))
                        .lineSpacing(34)
                        .offset(x: -115.50, y: -213)
                    
                    //Subtitle
                    Text("For Starters")
                        .font(Font.custom("Rubik", size: 14))
                        .lineSpacing(24)
                        .foregroundColor(Color(red: 0.41, green: 0.42, blue: 0.50))
                        .offset(x: -118.50, y: -183)
                    
                    
                    //Text
                    Text("Learn the basics of the language: make new friends, plan \na family dinner, go shopping and much more!")
                        .font(Font.custom("Rubik", size: 12))
                        .lineSpacing(12)
                        .foregroundColor(Color(red: 0.41, green: 0.42, blue: 0.50))
                        .offset(x: 5, y: -137)
                        .padding(.horizontal, 20)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                }
                
                
                // Circles and Text Area
                Group {
                    //Circles Column
                    Circle()
                        .frame(width: 65, height: 65)
                        .foregroundColor(Color(red: 0.93, green: 0.94, blue: 0.97))
                        .cornerRadius(65/2)
                        .offset(x: -144, y: -13.50)
                    
                    Circle()
                        .frame(width: 65, height: 65)
                        .foregroundColor(Color(red: 0.93, green: 0.94, blue: 0.97))
                        .cornerRadius(65/2)
                        .offset(x: -144, y: 101.50)
                    
                    Circle()
                        .frame(width: 65, height: 65)
                        .foregroundColor(Color(red: 0.93, green: 0.94, blue: 0.97))
                        .cornerRadius(65/2)
                        .offset(x: -144, y: 213.50)
                    
                    //Top
                    Rectangle()
                        .foregroundColor(Color(red: 0.93, green: 0.94, blue: 0.97))
                        .frame(width: 13, height: 65)
                        .offset(x: -144, y: -60)
                    
                    //Middle
                    
                    Rectangle()
                        .foregroundColor(Color(red: 0.93, green: 0.94, blue: 0.97))
                        .frame(width: 13, height: 65)
                        .offset(x: -144, y: 46)
                    
                    
                    //Last
                    Rectangle()
                        .foregroundColor(Color(red: 0.93, green: 0.94, blue: 0.97))
                        .frame(width: 13, height: 65)
                        .offset(x: -144, y: 157)
                    
                    
                    
                    
                    
                    Text("Firts Letters")
                        .font(Font.custom("Circular Std", size: 16).weight(.bold))
                        .lineSpacing(34)
                        .offset(x: -50, y: -36)
                    
                    Text("Firts Phrase")
                        .font(Font.custom("Circular Std", size: 16).weight(.bold))
                        .lineSpacing(34)
                        .offset(x: -51, y: 87)
                    
                    Text("Family Dialogue")
                        .font(Font.custom("Circular Std", size: 16).weight(.bold))
                        .lineSpacing(34)
                        .offset(x: -34, y: 200)
                    
                    
                    
                    Text("Introducing yourself: greetings, \nname and age")
                        .font(Font.custom("Rubik", size: 12))
                        .lineSpacing(12)
                        .offset(x: 0, y: 11.50)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    
                    Text("Planning where to go with your friends")
                        .font(Font.custom("Rubik", size: 12))
                        .lineSpacing(12)
                        .offset(x: 20.50, y: 122)
                    
                    Text("talk about it your job and future plans")
                        .font(Font.custom("Rubik", size: 12))
                        .lineSpacing(12)
                        .offset(x: 20.50, y: 234)
                    
                    
                }
            }
            .frame(width: 353, height: 493)
            
            Spacer()
        }
    }
}

#Preview {
    HiraganaStartView()
}
