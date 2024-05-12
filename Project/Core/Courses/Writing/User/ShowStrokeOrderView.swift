//
//  ShowStrokeOrderView.swift
//  Project
//
//  Created by Kirandeep Kaur on 29/3/2024.
//

import SwiftUI

struct ShowStrokeOrderView: View {
    let character: Character
    let strokeOrderImages: [String]
    @State private var currentIndex = 0
    @State private var timer: Timer?
    @State private var StartWriting = false
    @ObservedObject var characters: Characters
    @Binding var selectedImage: Int
    
    var selectedCharacterExpectedPath: Binding<[Path]> {
        Binding(
            get: {
                characters.characters.first { $0.id == character.id }?.expectedPath ?? []
            },
            set: { newValue in
                if let index = characters.characters.firstIndex(where: { $0.id == character.id }) {
                    characters.characters[index].expectedPath = newValue
                }
            }
        )
    }
    

    var body: some View {
            VStack {
                HStack(spacing: 10){
                    NavigationLink(
                        destination: HiraganaLessonView().navigationBarHidden(true),
                        label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.headline)
                                .padding()
                        })
                    
                    ZStack(alignment: .leading){
                        Rectangle().foregroundColor(Color(hex: 0xe7e7e7)).frame(width: 300 , height:12).cornerRadius(20)
                        Rectangle().foregroundColor(Color(hex: 0xd52d37)).frame(width: 130 , height:12).cornerRadius(20)
                    }
                    
                    
                    Spacer()
                    
                }.padding(.top)
                
                Spacer()
                
                if let currentImage = strokeOrderImages.element(at: currentIndex) {
                    Image(currentImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:200, height:200)
                        .padding()
                }
                
                Spacer()
                
                ZStack {
                    Rectangle()
                        .frame(width: 360, height: 190)
                        .foregroundColor(Color(hex: 0xDEE3F4))
                        .padding(.bottom, 15)
                        .cornerRadius(15)
                        .padding(.bottom, -15)
                    
                    
                    VStack{
                        Rectangle()
                            .frame(width: 310, height: 91)
                            .cornerRadius(30)
                            .foregroundColor(Color.white)
                            .overlay(
                                Text(character.name)
                                    .font(.title3.bold())
                                    .foregroundColor(.black)
                                
                            )
                        
                        Button(action: {
                            // Button action
                            // print("DEBUG: Start Learning Button Clicked")
                            
                            StartWriting = true
                        }) {
                            Text("Start Writing")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 150, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 25)
                                        .foregroundColor(Color(hex: 0xa92028))
                                )
                        }
                        .padding(.top, 5)
                        .background(
                            NavigationLink(
                                destination: WriteCharUserView(character: character, expectedPath: selectedCharacterExpectedPath, selectedImage: $selectedImage).navigationBarHidden(true),
                                isActive: $StartWriting,
                                label: {
                                    EmptyView()
                                }
                            )
                        )
                        
                    }
                    Rectangle()
                        .frame(width: 101, height: 32)
                        .cornerRadius(33)
                        .foregroundColor(Color(hex: 0x525F7F))
                        .offset(x: 0, y: -94)
                        .overlay(
                            Text("New")
                                .font(.callout.bold())
                                .foregroundColor(.white)
                                .offset(x: 0, y: -94) 
                        )
                    
                }
                
                
            }
        .onAppear {
            startAnimating()
        }
        .onDisappear {
            stopAnimating()
        }
    }

    private func startAnimating() {
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            currentIndex = (currentIndex + 1) % strokeOrderImages.count
        }
    }

    private func stopAnimating() {
        timer?.invalidate()
        timer = nil
    }
}

extension Array {
    func element(at index: Int) -> Element? {
        guard index >= 0 && index < count else {
            return nil
        }
        return self[index]
    }
}
