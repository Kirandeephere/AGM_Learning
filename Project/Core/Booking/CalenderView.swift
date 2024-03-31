//
//  CalenderView.swift
//  Project
//
//  Created by Kirandeep Kaur on 22/3/2024.
//

import SwiftUI
import FirebaseFirestore

import SwiftUI
import Firebase


struct CalendarView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var bookings: [Booking] = []
    @State private var isShowingBookingView = false
    
    
    var body: some View {
            VStack {
                ZStack {
                    HStack(spacing: 0) {
                        VStack() {
                            Image("calendar")
                                .font(Font.custom("Alatsi-Regular", size: 25))
                                .foregroundColor(Color(hex: 0xA92028))
                                .offset(x: 30, y: -12)
                        }
                        .frame(width: 74, height: 74)
                    }
                    .frame(width: 74, height: 74)
                    .offset(x: -150, y: 12)
                    
                    Text("Calendar")
                        .font(.title)
                        .fontWeight(.semibold)
                        .offset(x: -25, y: -20)
                    
                    NavigationLink(destination: MyBookingView()) {
                        Text("Check all upcoming appointments >")
                            .font(Font.custom("Alatsi-Regular", size: 15))
                            .foregroundColor(Color(hex: 0xA92028))
                            .offset(x: 40, y: 16.50)
                    }
                }
                .frame(width: 319, height: 74)
                .padding(.top, 30)
                .padding(.bottom, 40)
                

                CustomCalendar()

                Spacer()
            }

    }
}

