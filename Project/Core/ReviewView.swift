//
//  ReviewView.swift
//  Project
//
//  Created by Kirandeep Kaur on 22/3/2024.
//

import SwiftUI

struct ReviewView: View {
    var body: some View {
        VStack(alignment: .center){
            Text("Review!")
            
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
        }
    }
}

#Preview {
    ReviewView()
}
