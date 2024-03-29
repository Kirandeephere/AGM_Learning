//
//  UpcomingBookings.swift
//  Project
//
//  Created by Kirandeep Kaur on 28/3/2024.
//

import SwiftUI

struct UpcomingBookings: View {
    let bookings: [Booking]
    @State private var selectedCardIndex = 0

    var body: some View {
        VStack(alignment: .center) {
            ZStack(alignment: .center){
                ForEach(bookings.indices) { index in
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Color(red: 0.71, green: 0.22, blue: 0.25))
                        .frame(width: 324, height: 160)
                        .overlay(
                            VStack {
                                HStack {
                                    Image(systemName: "mappin.and.ellipse")
                                        .resizable()
                                        .frame(width: 40, height: 50)
                                        .foregroundColor(.white)

                                    VStack {
                                        Text(bookings[index].subject)
                                            .multilineTextAlignment(.center)
                                            .font(Font.custom("Alatsi", size: 20))
                                            .foregroundColor(.white)
                                            .padding(.bottom)

                                        Text("With \(bookings[index].volunteer)")
                                            .font(Font.custom("Alatsi", size: 15))
                                            .foregroundColor(.white)
                                    }
                                }

                                ZStack {
                                    RoundedRectangle(cornerRadius: 9)
                                        .foregroundColor(Color(red: 0.51, green: 0.03, blue: 0.06))
                                        .frame(width: 279, height: 45)

                                    HStack {
                                        Image(systemName: "calendar.badge.checkmark")
                                            .resizable()
                                            .frame(width: 23, height: 20)
                                            .foregroundColor(.white)
                                        
                                        Text(formattedDate(from: bookings[index].date))
                                            .font(Font.custom("Alatsi", size: 15))
                                            .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))

                                        Image(systemName: "clock.fill")
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(Color.white)

                                        Text(bookings[index].time)
                                            .font(Font.custom("Alatsi", size: 15))
                                            .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                                    }
                                }
                            }
                        )
                        .opacity(selectedCardIndex == index ? 1 : 0)
                        .animation(.easeInOut)
                }
            }

            HStack(spacing: 8) {
                ForEach(bookings.indices) { index in
                    Button(action: {
                        selectedCardIndex = index // Update the selectedCardIndex here
                    }) {
                        Circle()
                            .foregroundColor(selectedCardIndex == index ? Color(red: 0.51, green: 0.03, blue: 0.06) : .gray)
                            .frame(width: 10, height: 10)
                    }
                }
            }
            .padding(.top, 10)
        }
    }

    private func formattedDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}
