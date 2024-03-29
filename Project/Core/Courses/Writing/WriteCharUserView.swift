//
//  WriteCharUserView.swift
//  Project
//
//  Created by Kirandeep Kaur on 29/3/2024.
//

import SwiftUI

struct WriteCharUserView: View {
    let character: Character
    @Binding var expectedPath: [Path]
    @State private var currentPath = Path()
    @State private var paths: [Path] = []
    @State private var showingCurrentPath = false
    @State private var matchPercentage: Double = 0.0
    let dismissAction: () -> Void

    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    Image(character.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
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
                                calculateMatchPercentage()
                            })
                    )
                }
                .frame(width: geometry.size.width, height: geometry.size.width) // Adjust the frame size as needed
            }

            HStack {
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

                Button(action: {
                    showingCurrentPath = true
                }) {
                    Text("Done")
                        .font(.headline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                Button(action: dismissAction) {
                    Text("Dismiss")
                        .font(.headline)
                        .padding()
                }
                .padding()
            }

            if showingCurrentPath {
                VStack{
                    
                    Text("Matching Percentage: ")
                        .font(.headline)
                        .padding()
                    
                    HStack {
                        ForEach(0..<5) { index in
                            Image(systemName: index < Int(matchPercentage) ? "star.fill" : "star")
                                .foregroundColor(index < Int(matchPercentage) ? .yellow : .gray)
                        }
                    }

                }
               
            }
        }
    }

    private func resetDrawing() {
        currentPath = Path()
        paths = []
        showingCurrentPath = false
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

