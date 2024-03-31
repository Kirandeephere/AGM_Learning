//
//  HiraganaStartView.swift
//  Project
//
//  Created by Gursewak Singh on 28/3/2024.
//

import SwiftUI

struct HiraganaStartView: View {
    @State private var StartFirstLetters = false
    var body: some View {
        NavigationView{
            VStack{
                //Back Button
                HStack{
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.clear)
                            .frame(width: 40, height: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                        
                        NavigationLink(
                            destination: HomeView().navigationBarHidden(true),
                            label: {
                                Image(systemName: "chevron.backward")
                                    .font(Font.custom("Alatsi", size: 15))
                                    .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                            })
                        
                    }.padding(.top, 30).padding(.bottom, 30)
                    Spacer()
                }
                .padding(.leading, 25)
                
                // Middle Section
                ZStack() {
                    
                    //Info Box
                    Group {
                        //Background Square
                        Rectangle()
                            .foregroundColor(Color(hex: 0xfccccf))
                            .frame(width: 353, height: 158)
                            .cornerRadius(7)
                            .padding(.horizontal, 20)
                            .offset(x: 0, y: -167.50)
                        
                        //Title
                        Text("Hiragana")
                            .font(.title2.bold())
                            .foregroundColor(Color(hex: 0x430c0f))
                            .lineSpacing(34)
                            .padding(.horizontal, 10)
                            .offset(x: -115.50, y: -213)
                        
                        //Subtitle
                        Text("For Starters")
                            .font(.subheadline.bold())
                            .lineSpacing(24)
                            .foregroundColor(Color(hex: 0x7b2126))
                            .padding(.horizontal, 10)
                            .offset(x: -118.50, y: -183)
                        
                        
                        //Text
                        Text("Learn the basics of the language: make new friends,\n plan family dinner, go shopping and much more!")
                            .font(.footnote)
                            .lineSpacing(12)
                            .foregroundColor(Color(hex: 0x7b2126))
                            .padding(.horizontal, 10)
                            .offset(x: 5, y: -137)
                            .multilineTextAlignment(.leading)
                    }
                    
                    // Circles and Text Area
                    Group {
                        //Top
                        Rectangle()
                            .foregroundColor(Color(hex: 0xfccccf))
                            .frame(width: 13, height: 65)
                            .offset(x: -144, y: -60)
                        
                        //Middle
                        
                        Rectangle()
                            .foregroundColor(Color(hex: 0xfef2f3))
                            .frame(width: 13, height: 65)
                            .offset(x: -144, y: 46)
                        
                        
                        //Last
                        Rectangle()
                            .foregroundColor(Color(hex: 0xfef2f3))
                            .frame(width: 13, height: 65)
                            .offset(x: -144, y: 157)
                        
                        //Circles Column
                        Circle()
                            .frame(width: 65, height: 65)
                            .foregroundColor(Color(hex: 0xfccccf))
                            .cornerRadius(65/2)
                            .offset(x: -144, y: -13.50)
                        
                        Circle()
                            .frame(width: 65, height: 65)
                            .foregroundColor(Color(hex: 0xfef2f3))
                            .cornerRadius(65/2)
                            .offset(x: -144, y: 101.50)
                        
                        Circle()
                            .frame(width: 65, height: 65)
                            .foregroundColor(Color(hex: 0xfef2f3))
                            .cornerRadius(65/2)
                            .offset(x: -144, y: 213.50)
                        
                        
                        
                        Text("First Letters")
                            .font(.headline.bold())
                            .lineSpacing(18)
                            .foregroundColor(Color(hex: 0x7b2126))
                            .offset(x: -50, y: -26)
                        
                        Text("First Phrase")
                            .font(.headline.bold())
                            .lineSpacing(18)
                            .foregroundColor(Color(hex: 0x7b2126))
                            .offset(x: -51, y: 90)
                        
                        Text("Family Dialogue")
                            .font(.headline.bold())
                            .lineSpacing(18)
                            .foregroundColor(Color(hex: 0x7b2126))
                            .offset(x: -34, y: 200)
                        
                        
                        Text("Introducing yourself: \n greetings, name and age")
                            .font(.subheadline)
                            .foregroundColor(Color(hex: 0x7b2126))
                            .offset(x: 0, y: 10)
                            .multilineTextAlignment(.leading)
                        
                        Text("Planning where to go with your \n friends")
                            .font(.subheadline)
                            .foregroundColor(Color(hex: 0x7b2126))
                            .offset(x: 20.50, y: 122)
                        
                        Text("Talk about it your job and future \n plans")
                            .font(.subheadline)
                            .foregroundColor(Color(hex: 0x7b2126))
                            .offset(x: 24, y: 234)
                        
                        
                    }
                }
                .frame(width: 353, height: 493)
                
                Button(action: {
                    // Button action
                    print("DEBUG: Start Learning Button Clicked")
                    
                    StartFirstLetters = true
                }) {
                    Text("Start Learning")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 300, height: 68.69)
                        .background(
                            RoundedRectangle(cornerRadius: 52)
                                .foregroundColor(Color(hex: 0xa92028))
                        )
                }
                .padding(.top, 30)
                .background(
                    NavigationLink(
                        destination: HiraganaLessonView().navigationBarHidden(true),
                        isActive: $StartFirstLetters,
                        label: {
                            EmptyView()
                        }
                    )
                )
                
                Spacer()
            }
        }
        }
    }

#Preview {
    HiraganaStartView()
}
