//
//  CalenderView.swift
//  Project
//
//  Created by Kirandeep Kaur on 22/3/2024.
//

import SwiftUI

struct CalenderView: View {
    var body: some View {
        ZStack{
            Color.blue
            
            Image(systemName: "calendar")
                .foregroundColor(.white)
                .font(.system(size: 100.0))
        }
        
    }
}

#Preview {
    CalenderView()
}
