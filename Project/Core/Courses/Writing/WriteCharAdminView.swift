//
//  WriteCharAdminView.swift
//  Project
//
//  Created by Kirandeep Kaur on 29/3/2024.
//

import SwiftUI
import Firebase

struct WriteCharAdminView: View {
    let character: Character
    @Binding var expectedPath: [Path]
    @State private var currentPath = Path()
    @State private var paths: [Path] = []
    let dismissAction: () -> Void
    
    // Firebase reference to the expected path data
        private var expectedPathRef: DatabaseReference {
            Database.database().reference().child("characters").child("character\(character.id)").child("expectedPath")
        }

    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    Image(character.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:200, height:200)
                        .padding()
                    
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
                .frame(width: geometry.size.width, height: geometry.size.width) // Adjust the frame size as needed
            }
            
            HStack {
                Button(action: {
                    saveDrawing()
                }) {
                    Text("Save")
                        .font(.headline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                Button(action: {
                    fetchExpectedPath()
                }) {
                    Text("Show")
                        .font(.headline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
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
                .padding()
                
                Button(action: dismissAction) {
                            Text("Dismiss")
                                .font(.headline)
                                .padding()
                        }.padding()
            }
            
            PathView(path: expectedPath)
                .padding()
        }
    }
    
    //as string
    
    private func saveDrawing() {
            // Convert the paths to an array of CGPoint
            let pointsArrays = paths.map { $0.toCGPointArray() }
            
            // Save the points arrays to Firebase
            expectedPathRef.setValue(pointsArrays.map { array in
                array.map { ["x": $0.x, "y": $0.y] }
            }) { error, _ in
                if let error = error {
                    print("Error saving expected path to Firebase: \(error)")
                } else {
                    print("Expected path saved successfully!")
                }
            }
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
        
    
    private func resetDrawing() {
        currentPath = Path()
        paths = []
    }
}

struct PathView: View {
    let path: [Path]
    
    var body: some View {
        ZStack {
            ForEach(path.indices, id: \.self) { index in
                path[index] .stroke(Color.red, lineWidth: 3)
            }
        }
    }
}

