//
//  ShowStrokeOrderView.swift
//  Project
//
//  Created by Kirandeep Kaur on 29/3/2024.
//

import SwiftUI

struct ShowStrokeOrderView: View {
    let strokeOrderImages: [String]
    let dismissAction: () -> Void
    @State private var currentIndex = 0
    @State private var timer: Timer?

    var body: some View {
        VStack {
            if let currentImage = strokeOrderImages.element(at: currentIndex) {
                Image(currentImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:200, height:200)
                    .padding()
            }
            
            Button(action: dismissAction) {
                        Text("Dismiss")
                            .font(.headline)
                            .padding()
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
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
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
