//
//  SettingsRowView.swift
//  Project
//
//  Created by Gursewak Singh on 21/3/2024.
//

import SwiftUI

struct SettingsRowView: View {
    let imageName: String?
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack(spacing: 12){
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
            
            Spacer()
            
            if let imageName = imageName {
                Image(systemName: imageName)
                    .imageScale(.small)
                    .font(.title2)
                    .foregroundColor(tintColor)
                    .frame(width: 25, height: 25)
            }
        }
    }
}

#Preview {
    SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
}
