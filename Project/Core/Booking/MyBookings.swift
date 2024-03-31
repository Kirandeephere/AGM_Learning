//
//  MyBookings.swift
//  Project
//
//  Created by Kirandeep Kaur on 24/3/2024.
//

import SwiftUI
import Firebase

struct Booking: Identifiable {
    let id = UUID()
    let subject: String
    let volunteer: String
    let date: Date
    let time: String
    let duration: String
}

class BookingStore: ObservableObject {
    @Published var bookings: [Booking] = []
    
    @MainActor func fetchBookings(authViewModel: AuthViewModel) {
        if let currentUserId = authViewModel.currentUser?.id {
            print("Fetching bookings for user with ID: \(currentUserId)")
            
            let database = Database.database().reference()
            let userBookingsRef = database.child("Bookings").child(currentUserId)

            userBookingsRef.observeSingleEvent(of: .value) { snapshot in
                var fetchedBookings: [Booking] = []
                
                print("Received snapshot with \(snapshot.childrenCount) child nodes")

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd" // Set the correct date format

                for case let childSnapshot as DataSnapshot in snapshot.children {
                    if let appointmentData = childSnapshot.value as? [String: Any],
                       let duration = appointmentData["duration"] as? String,
                       let volunteer = appointmentData["name"] as? String,
                       let dateString = appointmentData["date"] as? String,
                       let time = appointmentData["time"] as? String,
                       let subject = appointmentData["subject"] as? String {

                        if let date = dateFormatter.date(from: dateString) {
                            // Ensure that the time components are set to midnight (00:00:00)
                            let calendar = Calendar.current
                            let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
                            if let dateWithoutTime = calendar.date(from: dateComponents) {
                                let booking = Booking(subject: subject, volunteer: volunteer, date: dateWithoutTime, time: time, duration: duration)
                                fetchedBookings.append(booking)
                            }
                        }
                    }
                }
                
                print("Fetched \(fetchedBookings.count) bookings")

                // Sort the bookings based on the date (in ascending order)
                fetchedBookings.sort { (booking1, booking2) -> Bool in
                    return booking1.date < booking2.date
                }

                // Update the main bookings array and trigger re-computation of filteredBookings
                self.bookings = fetchedBookings
                
                print("Updated bookings array with \(self.bookings.count) bookings")
            }
        } else {
            print("No current user ID found")
        }
    }
}

struct CardView: View {
    let bookings: [Booking]
    
    private func isToday(_ date: Date) -> Bool {
            return Calendar.current.isDateInToday(date)
        }
    

    var body: some View {
        VStack(spacing: 10) {
            ForEach(bookings) { booking in
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color(red: 0.98, green: 0.98, blue: 0.98))
                        .frame(width: 324, height: 140)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, x: 2, y: 2)

                    // Card content: Display formatted date, time, hospital, and volunteer information
                    VStack(alignment: .center) {
                        
                        Text("Subject: \(booking.subject)")
                            .font(Font.custom("Alatsi-Regular", size: 15))
                            .foregroundColor(.black)
                            .frame(width:250)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 3)
                        
                        Text("Volunteer: \(booking.volunteer)")
                            .font(Font.custom("Alatsi-Regular", size: 15))
                            .foregroundColor(.black)
                            .lineLimit(1)
                            .padding(.vertical, 3)
                        
                        Text("Duration: \(booking.duration)")
                            .font(Font.custom("Alatsi-Regular", size: 15))
                            .foregroundColor(.black)
                            .lineLimit(1)
                            .padding(.vertical, 3)
                        
                        HStack{
                            Text(formattedDate(from: booking.date))
                                .font(Font.custom("Alatsi-Regular", size: 23))
                                .foregroundColor(.black)
                                .lineLimit(1)
                                .padding(.trailing)
                
                            
                            Text(booking.time)
                                .font(Font.custom("Alatsi-Regular", size: 23))
                                .foregroundColor(.black)
                                .lineLimit(1)
                    
                                
                        }.padding(.vertical, 3)
                       
                    }
                    .padding(.trailing,15)

                    if isToday(booking.date) { // Check if the booking's date is today
                        Text("Today")
                            .font(Font.custom("Alatsi-Regular", size: 14))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color(red: 0.48, green: 0.13, blue: 0.15))
                            .cornerRadius(8)
                            .offset(x: 130, y: -50)
                    }
                }
                .id(UUID())
                .padding(.top)
            }
        }
    }

    private func formattedDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}

struct MyBookingView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var bookingStore: BookingStore
    @State private var selectedFilter = 0 // 0 for "Today+future Appointments", 1 for "Past Appointments"
    
    var filteredBookings: [Booking] {
        let currentDate = Date()
        if selectedFilter == 0 {
            // Filter today and future appointments
            return bookingStore.bookings.filter { $0.date >= Calendar.current.startOfDay(for: currentDate) }
        } else {
            // Filter past appointments
            return bookingStore.bookings.filter { $0.date < Calendar.current.startOfDay(for: currentDate) }
        }
    }
    
    
    var body: some View {
            VStack {
                
                // Header Starts
                VStack(alignment: .center){
                    
                    Text("My Bookings")
                        .font(Font.custom("Alatsi-Regular", size: 25))
                        .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                        
                }.padding()
                
              
                
                
                // Segmented Picker
                Picker("", selection: $selectedFilter) {
                    Text("Today · Future").tag(0)
                    
                    Text("Past").tag(1)

                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                // End of Segmented Picker
                
                // Scroll View Starts
                GeometryReader { geometry in
                    ScrollView {
                        if !filteredBookings.isEmpty {
                            CardView(bookings: filteredBookings)
                                .frame(width: geometry.size.width) // Make the CardView match the width of the GeometryReader
                        } else {
                            VStack(alignment: .center){
                                Text("No bookings found.")
                                    .foregroundColor(Color(red: 0.71, green: 0.22, blue: 0.25))
                            }.padding()
                           
                        }
                    }
                }
                // Scroll View Ends
                
                Spacer() // Add any additional spacing if needed
                
            }
    }
    
    
    
}
