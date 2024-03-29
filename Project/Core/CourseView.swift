//
//  CourseView.swift
//  Project
//
//  Created by Kirandeep Kaur on 22/3/2024.
//

import SwiftUI

struct CourseView: View {
    @State private var paths: [Path] = []
    @State private var currentPath = Path()
    
    var body: some View {
        NavigationView{
        VStack {
            Text("CourseView!")
            
            //header
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
            }
            
            GeometryReader { geometry in
                ZStack {
                    Image("template")
                        .resizable()
                        .scaledToFit()
                    
                    // Drawing paths
                    ForEach(paths.indices, id: \.self) { index in
                        Path { path in
                            path.addPath(paths[index])
                        }
                        .stroke(Color.blue, lineWidth: 3)
                    }
                    
                    Path { path in
                        path.addPath(self.currentPath)
                    }
                    .stroke(Color.blue, lineWidth: 3)
                    .background(Color.white.opacity(0.001))
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged({ value in
                                let touchPoint = value.location
                                if self.currentPath.isEmpty {
                                    self.currentPath.move(to: touchPoint)
                                } else {
                                    self.currentPath.addLine(to: touchPoint)
                                }
                            })
                            .onEnded({ value in
                                self.paths.append(self.currentPath)
                                self.currentPath = Path()
                            })
                    )
                }
            }
            
            Button(action: {
                resetDrawing()
            }) {
                Text("Reset")
                    .font(.headline)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        }
    }
    
    private func resetDrawing() {
        paths.removeAll()
        currentPath = Path()
    }
}

#Preview {
    CourseView()
}
