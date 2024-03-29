//
//  HiraganaLessonView.swift
//  Project
//
//  Created by Gursewak Singh on 28/3/2024.
//

import SwiftUI

struct HiraganaLessonView: View {
    @State private var selectedTask: String = "Start Lesson 1" //Selected by default

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
                Text("Hiragana")
                     .font(Font.custom("Circular Std", size: 30).weight(.bold))
                     .lineSpacing(34)
                     .foregroundColor(Color(red: 0.41, green: 0.42, blue: 0.50))
                     .offset(x: 0, y: -60)

                
                Text("0 / 3")
                      .font(Font.custom("Rubik", size: 14))
                      .lineSpacing(8)
                      .foregroundColor(Color(red: 0.41, green: 0.42, blue: 0.50))
                      .multilineTextAlignment(.center)
                      .offset(x: 0, y: -20)
            
            
            //Lesson Box Selection
            TaskSelectionRow(task: "Start Lesson 1", isSelected: selectedTask == "Start Lesson 1") {
                            selectedTask = "Start Lesson 1"
                       }
                        TaskSelectionRow(task: "Start Lesson 2", isSelected: selectedTask == "Start Lesson 2") {
                            selectedTask = "Start Lesson 2"
                       }
                        TaskSelectionRow(task: "Start Lesson 3", isSelected: selectedTask == "Start Lesson 3") {
                            selectedTask = "Start Lesson 3"
                       }
                
                Spacer()
            }
            .offset(x:0, y : 150)
        }
    }
}


//Selection Function
struct TaskSelectionRow: View {
    let task: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                
                Ellipse()
                    .foregroundColor(isSelected ? .green : Color(red: 0.77, green: 0.78, blue: 0.85))
                    .frame(width: 43.3, height: 52.8)
                    .offset(x: 40, y: 0)

                    
                Spacer()


                
                Text(task)
                    .font(Font.custom("Circular Std", size: 20).weight(.medium))
                    .lineSpacing(34)
                    .foregroundColor(isSelected ? .green : Color(red: 0.41, green: 0.42, blue: 0.50))
                    .padding(.leading, -50)

                Spacer()

            }
            .frame(width: 352, height: 105)
            .background(Color(red: 0.93, green: 0.94, blue: 0.97))
            .cornerRadius(10)
            .padding(.top, 10)
        }
        .padding(.top, 10)
    }
}

#Preview {
    HiraganaLessonView()
}
