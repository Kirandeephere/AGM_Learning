//
//  WriteCharUserView.swift
//  Project
//
//  Created by Kirandeep Kaur on 29/3/2024.
//

import SwiftUI
import Firebase

struct WriteCharUserView: View {
    let character: Character
    @Binding var expectedPath: [Path]
    @State private var currentPath = Path()
    @State private var paths: [Path] = []
    @State private var checkpath = false
    @State private var matchPercentage: Double = 0.0
    @State private var result = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var selectedImage: Int
    @State private var gonext = false

    var user: User? {
        viewModel.currentUser
    }
    
    private var expectedPathRef: DatabaseReference {
        Database.database().reference().child("characters").child("character\(character.id)").child("expectedPath")
    }
    
    private func fetchExpectedPath() {
        expectedPathRef.observeSingleEvent(of: .value) { snapshot, error in
            guard let pointsArrays = snapshot.value as? [[[String: CGFloat]]] else {
                // Handle the case where the data is not available or cannot be decoded/unarchived
                return
            }
            
            let paths = pointsArrays.map { pointsArray -> Path in
                let points = pointsArray.compactMap { dict -> CGPoint? in
                    if let x = dict["x"], let y = dict["y"] {
                        return CGPoint(x: x, y: y)
                    }
                    return nil
                }
                return Path { path in
                    path.addLines(points)
                }
            }
            
            expectedPath = paths
        }
    }
    
    private func saveCompletionToDatabase() {
        guard let user = viewModel.currentUser else {
            print("User is not authenticated.")
            return
        }
        
        var characterId = character.id

        if selectedImage == 1 {
            characterId = character.id + 1
        }
        else if selectedImage == 2 {
            characterId = (character.id * 2) - 1
        }
        else if selectedImage == 3 {
            characterId = character.id * 2
        }
        
        
        
        let database = Database.database().reference()
        let completedItemsRef = database.child("Course").child(user.id).child("completedItems")
        completedItemsRef.setValue(characterId) { error, _ in
            if let error = error {
                print("Error saving completed item:", error)
            } else {
                print("Completed item upated to the database.")
            }
        }
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
                        Rectangle().foregroundColor(Color(hex: 0xd52d37)).frame(width: 250 , height:12).cornerRadius(20)
                    }
                    
                    Spacer()
                    
                }.padding(.top)
                
                Spacer()
                
                //Reset Button
                HStack{
                    Spacer ()
                    Button(action: {
                        resetDrawing()
                    }) {
                        Image(systemName: "arrow.circlepath")
                            .resizable()
                            .frame(width: 24, height: 20)
                            .foregroundColor(.black)
                            .padding(.trailing)
                    }
                    
                    
                }
                
                //Drawing Section
                GeometryReader { geometry in
                    ZStack {
                        if selectedImage == 0 || selectedImage == 2{
                            Image(character.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 310, height: 310)
                                .padding()
                        } else if selectedImage == 1 || selectedImage == 3 {
                            Image(character.dotsImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 310, height: 310)
                                .padding()
                        }
                        
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
                                    calculateMatchPercentage()
                                })
                        )
                    }
                    .frame(width: geometry.size.width, height: geometry.size.width) // Adjust the frame size as needed
                }
                
                if(!checkpath){
                    Button(action: {
                        checkpath = true
                        saveCompletionToDatabase()
                    }) {
                        ZStack{
                            Rectangle()
                                .frame(width: 300, height: 68.69)
                                .foregroundColor(Color(hex: 0xA92028))
                                .cornerRadius(50)
                            
                            Text("Done")
                                .foregroundColor(.white)
                                .font(.headline.bold())
                        }
                    }
                    .padding()
                }
                else {
                    VStack{
                        ZStack{
                            
                            Rectangle()
                                .frame(width: 360, height: 190)
                                .foregroundColor(Color(hex: 0xDEE3F4))
                                .cornerRadius(15)
                                
                            
                            VStack {
                                Spacer()
                                Text(result)
                                    .font(.headline.bold())
                                    .foregroundColor(Color(hex:0x686C80))
                                    .padding()
                                
                                HStack {
                                    
                                    ForEach(0..<5) { index in
                                        Image(systemName: index < Int(matchPercentage) ? "star.fill" : "star")
                                            .resizable().frame(width:25, height:25)
                                            .foregroundColor(index < Int(matchPercentage) ? .yellow : .gray)
                                        
                                    }
                                }
                                
                                if (matchPercentage == 0) {
                                    Button(action: {
                                        checkpath = false
                                        resetDrawing()
                                    }) {
                                        ZStack{
                                            Rectangle()
                                                .frame(width: 300, height: 68.69)
                                                .foregroundColor(Color(hex: 0xA92028))
                                                .cornerRadius(50)
                                            
                                            Text("Retry")
                                                .foregroundColor(.white)
                                                .font(.headline.bold())
                                        }.padding()
                                    }
                                    
                                }else{
                                    HStack(spacing: 20){

                                        Button(action: {
                                            checkpath = false
                                            resetDrawing()
                                        }) {
                                            ZStack{
                                                Rectangle()
                                                    .frame(width: 150, height: 40)
                                                    .foregroundColor(Color(hex: 0xA92028))
                                                    .cornerRadius(50)
                                                
                                                Text("Retry")
                                                    .foregroundColor(.white)
                                                    .font(.headline.bold())
                                            }
                                        }
                                        
                                        Button(action: {
                                            gonext = true
                                        }) {
                                            ZStack{
                                                Rectangle()
                                                    .frame(width: 150, height: 40)
                                                    .foregroundColor(Color(hex: 0xA92028))
                                                    .cornerRadius(50)
                                                
                                                Text("Next")
                                                    .foregroundColor(.white)
                                                    .font(.headline.bold())
                                            }
                                        }
                                    }.padding()
                                    
                                }
                                
                                
                                Spacer()
                                
                                NavigationLink(destination: HiraganaLessonView().navigationBarHidden(true), isActive: $gonext) {
                                    EmptyView()
                                }
                            }
                            .onAppear {
                                switch Int(matchPercentage) {
                                case 5:
                                    result = "Perfect"
                                case 4:
                                    result = "Good"
                                case 3:
                                    result = "Average"
                                case 2:
                                    result = "Below Average"
                                case 1:
                                    result = "Poor"
                                default:
                                    result = "Try Again"
                                }
                            }
                        }
                    }
                }
            }
        .onAppear {
                fetchExpectedPath()
            }

    }

    private func resetDrawing() {
        currentPath = Path()
        paths = []
        checkpath = false
        matchPercentage = 0.0
    }
    
    
    private func calculateMatchPercentage() {
        guard let currentPoints = paths.last?.toCGPointArray(),
              let expectedPoints = expectedPath.last?.toCGPointArray() else {
            matchPercentage = 0
            return
        }

        let totalPoints = expectedPoints.count
        var matchingPoints = 0

        for currentPoint in currentPoints {
            for expectedPoint in expectedPoints {
                let distance = sqrt(pow(currentPoint.x - expectedPoint.x, 2) + pow(currentPoint.y - expectedPoint.y, 2))
                if distance <= 10 { // Adjust the threshold as needed
                    matchingPoints += 1
                    break
                }
            }
        }

        let percentage = (Double(matchingPoints) / Double(totalPoints)) * 100.0
        let rating: Int

        if percentage <= 10 {
            rating = 0
        } else if percentage < 25 {
            rating = 1
        } else if percentage <= 35 {
            rating = 2
        } else if percentage <= 55 {
            rating = 3
        } else if percentage <= 80 {
            rating = 4
        } else {
            rating = 5
        }

        matchPercentage = Double(rating)
    }
}

extension Path {
    func toCGPointArray() -> [CGPoint] {
        var points: [CGPoint] = []
        var currentPoint: CGPoint?
        self.forEach { element in
            switch element {
            case .move(let to):
                currentPoint = to
            case .line(let to):
                currentPoint = to
            case .quadCurve(let to, let control):
                currentPoint = to
                points.append(control)
            case .curve(let to, let control1, let control2):
                currentPoint = to
                points.append(control1)
                points.append(control2)
            case .closeSubpath:
                currentPoint = nil
            }
            if let point = currentPoint {
                points.append(point)
            }
        }
        return points
    }
}

