//
//  CalenderView.swift
//  Project
//
//  Created by Kirandeep Kaur on 22/3/2024.
//

import SwiftUI
import Firebase


struct CalendarView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var bookings: [Booking] = []
    @State private var isShowingBookingView = false
    
    var body: some View {
        VStack {
            Text("Upcoming Bookings")
                .font(.headline)
            
            Button(action: {
                isShowingBookingView = true
            }) {
                Text("View")
            }
            .sheet(isPresented: $isShowingBookingView) {
                MyBookingView()
            }
        }
    }
}

#Preview {
    CalendarView()
}
