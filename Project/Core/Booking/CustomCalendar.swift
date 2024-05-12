//
//  CustomCalendar.swift
//  Project
//
//  Created by Kirandeep Kaur on 27/3/2024.
//

import SwiftUI

struct CustomCalendar: View {
    
    @State private var color: Color = .white
    @State private var date = Date()
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var days: [Date] = []
    @State private var selectedDate: Date?
    @State private var selectedBooking: Booking?
    
    @EnvironmentObject var bookingStore: BookingStore // Inject the BookingStore as an environment object
    
    var body: some View {
        VStack {
            HStack {
                Text("\(date.formatted(.dateTime.month(.wide))) \(date.formatted(.dateTime.year()))")
                    .padding(.horizontal).font(.title2.bold())
                
                Spacer()
                
                HStack(spacing: 20){
                    Button(action: {
                        decreaseMonth()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }.onTapGesture {
                        selectedBooking = nil
                    }
                    
                    Button(action: {
                        increaseMonth()
                    }) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                    }.onTapGesture {
                        selectedBooking = nil
                    }
                }
            }.padding(.bottom)
            
            HStack {
                ForEach(daysOfWeek.indices, id: \.self) { index in
                    Text(daysOfWeek[index])
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                }
            }
            
            LazyVGrid(columns: columns) {
                ForEach(days, id: \.self) { day in
                    if day.monthInt != date.monthInt {
                        Text("")
                    } else {
                        let hasBooking = bookingStore.bookings.contains { booking in
                            Calendar.current.isDate(booking.date, inSameDayAs: day)
                        }
                        
                        Button(action: {
                            selectedDate = day
                            selectedBooking = bookingStore.bookings.first(where: { Calendar.current.isDate($0.date, inSameDayAs: day) })
                        }) {
                            Text(day.formatted(.dateTime.day()))
                                .font(.callout)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, minHeight: 40)
                                .background(
                                    ZStack {
                                        Circle()
                                            .foregroundStyle(
                                                Date.now.startOfDay == day.startOfDay
                                                    ? .red.opacity(0.3)
                                                    :  color.opacity(0.3)
                                            )
                                        
                                        if hasBooking {
                                            Circle()
                                                .fill(Color.red)
                                                .frame(width: 8, height: 8)
                                                .offset(y: 16)
                                        }
                                    }
                                )
                        }
                        .onTapGesture(count: 2) {
                            selectedDate = nil
                            selectedBooking = nil
                        }
                    }
                }
            }
            
            Spacer() // Add Spacer
            
            if let selectedBooking = selectedBooking {
                CardPopUp(booking: selectedBooking)
                Spacer() // Add Spacer
            }else{
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.clear)
                    .padding(15)
                    .frame(width: 324, height: 160)
                Spacer() // Add Spacer
            }
        }
        .padding()
        .onAppear {
            days = date.calendarDisplayDays
        }
        .onChange(of: date) {
            days = date.calendarDisplayDays
        }
    }
    
    private func increaseMonth() {
        date = Calendar.current.date(byAdding: .month, value: 1, to: date) ?? Date()
    }
    
    private func decreaseMonth() {
        date = Calendar.current.date(byAdding: .month, value: -1, to: date) ?? Date()
    }
}

struct CardPopUp: View {
    let booking: Booking
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .foregroundColor(Color(hex: 0xb63940))
            .padding(15)
            .frame(width: 324, height: 160)
            .overlay(
                VStack(alignment: .leading){
                    Text(booking.subject)
                        .font(.body.bold())
                        .foregroundColor(.white)
                        .padding(.leading)
                    
                    HStack{
                        Text("with")
                            .font(.body.bold())
                            .foregroundColor(.white)
                            .padding(.leading)
                        
                        Text(booking.volunteer)
                            .font(.body.bold())
                            .foregroundColor(.white)
                    }
                    HStack{
                        Text("for")
                            .font(.body.bold())
                            .foregroundColor(.white)
                            .padding(.leading)
                        
                        Text(formatDuration(booking.duration))
                            .font(.body.bold())
                            .foregroundColor(.white)
                    }

                    ZStack{
                        RoundedRectangle(cornerRadius: 9)
                            .foregroundColor(Color(hex: 0x83080F))
                            .padding(2.5)
                            .frame(width: 279, height: 45)
                        HStack(spacing: 22){
                            HStack{
                                Image(systemName: "calendar.badge.checkmark")
                                    .resizable()
                                    .frame(width: 20 , height: 20)
                                    .foregroundColor(.white)
                                
                                Text(formatBookingDate(booking.date))
                                    .font(.body.bold())
                                    .foregroundColor(.white)
                                
                            }
                            HStack{
                                Image(systemName: "clock.fill")
                                    .resizable()
                                    .frame(width: 19 , height: 19)
                                    .foregroundColor(.white)
                                
                                Text(booking.time)
                                    .font(.body.bold())
                                    .foregroundColor(.white)
                                
                            }
                        }
                    }
                }.padding(.vertical)
            )
    }
}

private func formatBookingDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    return dateFormatter.string(from: date)
}

private func formatDuration(_ duration: String) -> String {
        let components = duration.components(separatedBy: " ")
        if components.count == 4 {
            let hours = components[0]
            let minutes = components[2]
            return "\(hours) hr \(minutes) mins"
        }
        return duration
    }

#Preview {
    CustomCalendar()
}
