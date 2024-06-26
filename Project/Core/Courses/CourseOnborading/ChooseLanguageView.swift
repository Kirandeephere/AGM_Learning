//
//  ChooseLanguageView.swift
//  Project
//
//  Created by Gursewak Singh on 25/3/2024.
//

import SwiftUI


struct ChooseLanguageView: View {
    @State private var selectedLanguage: String = ""
    
    @State private var IfLanguageSelected = false
    
    var body: some View {
        NavigationView{
            VStack{
                
                HStack{
                    //Back Button Arrow
                    NavigationLink(destination: HomeView().navigationBarHidden(true)) {
                        Image("backarrow")
                            .font(.title)
                        
                    }
                    Spacer()
                }.padding(.leading, 20)
                
                //Headers - Title, Subtitle
                VStack(spacing: 10){
                    Text("Choose a language")
                        .font(Font.custom("Alatsi-Regular", size: 30))
                        .lineSpacing(34)
                        .foregroundColor(Color(hex: 0x686C80))
                        .padding(.top)
                    
                    
                    
                    Text("What language would you like to start with? \nYou can change it at any time!")
                        .font(Font.custom("Alatsi-Regular", size: 14))
                        .lineSpacing(8)
                        .foregroundColor(Color(hex: 0x686C80))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 20)
                    
                    
                    //If a language is selected then goes to NewView.
                    NavigationLink(destination: ChooseGoalsView().navigationBarHidden(true), isActive: $IfLanguageSelected) {
                        EmptyView()
                    }
                    
                    
                    //Languages Box Selection
                    LanguageSelectionRow(language: "Japanese", isSelected: selectedLanguage == "Japanese") {
                        selectedLanguage = "Japanese"
                        IfLanguageSelected = true
                        
                    }
                    LanguageSelectionRow(language: "English", isSelected: selectedLanguage == "English") {
                        selectedLanguage = "English"
                        IfLanguageSelected = true
                        
                    }
                    LanguageSelectionRow(language: "Portuguese", isSelected: selectedLanguage == "Portuguese") {
                        selectedLanguage = "Portuguese"
                        IfLanguageSelected = true
                        
                    }
                }
                .padding(.top)
                .padding(.horizontal, 20)
                
                Spacer()
                
            }.padding(.top)
        }
        
    }
}
//Selection Function
struct LanguageSelectionRow: View {
    let language: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                
                Circle()
                    .foregroundColor(isSelected ? Color(hex: 0xA92028) : Color(hex: 0xC5C8D8))
                    .frame(width: 39)
                    .aspectRatio(1, contentMode: .fit)
                    .offset(x: 40, y: 0)

                    
                Spacer()


                
                Text(language)
                    .font(Font.custom("Alatsi-Regular", size: 20))
                    .lineSpacing(34)
                    .foregroundColor(isSelected ? Color(hex: 0xA92028) : Color(hex: 0x686C80))
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
    ChooseLanguageView()
}
