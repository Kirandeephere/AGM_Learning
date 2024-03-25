//
//  BookingView.swift
//  Project
//
//  Created by Kirandeep Kaur on 24/3/2024.
//

import SwiftUI
import Firebase

struct BookingView: View {
    let helpTypes = ["Homework", "Study", "Project", "Exam", "Other"]
    let name: String
    let subject: String

    @State private var description: String = ""
    @State private var selectedHelpType: String = ""
    @State private var otherHelpType: String = ""
    @State private var selectedDate: Date = Date()
    @State private var selectedTime: Date = Date()
    @State private var selectedDuration: TimeInterval = 0
    @State private var isShowingBookCompletionAlert = false
    @State private var isNavigatingToHomeView = false
    @EnvironmentObject var viewModel: AuthViewModel

    var user: User? {
        viewModel.currentUser
    }
    
    
    var nextDate: Date {
            let calendar = Calendar.current
            return calendar.date(byAdding: .day, value: 1, to: Date()) ?? Date()
        }
    
    private func saveBookingToFirebase() {
        if let user = viewModel.currentUser {
            let userBookingsRef = Database.database().reference().child("Bookings").child(user.fullname)
            let bookingID = userBookingsRef.childByAutoId().key ?? ""
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: selectedDate)
            
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            let timeString = timeFormatter.string(from: selectedTime)
            
            let durationFormatter = DateComponentsFormatter()
            durationFormatter.unitsStyle = .full
            durationFormatter.allowedUnits = [.hour, .minute]
            let durationString = durationFormatter.string(from: selectedDuration)
            
            let bookingDetails: [String: Any] = [
                "name": name,
                "subject": subject,
                "description": description,
                "helpType": selectedHelpType,
                "otherHelpType": otherHelpType,
                "date": dateString,
                "time": timeString,
                "duration": durationString ?? ""
            ]

            let childUpdates = ["/\(bookingID)": bookingDetails]
            userBookingsRef.updateChildValues(childUpdates) { error, _ in
                if let error = error {
                    print("Error saving booking to Firebase: \(error)")
                } else {
                    print("Booking saved successfully to Firebase")
                }
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Booking Details")
                .font(.largeTitle)
                .padding()

            ScrollView{
                VStack(alignment: .leading){
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Name")
                            .font(.headline)
                        Text(name)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color(.systemGray5))
                            .cornerRadius(8)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Subject")
                            .font(.headline)
                        Text(subject)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color(.systemGray5))
                            .cornerRadius(8)
                    }
                    
                    TextField("Description", text: $description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Picker("Help Type", selection: $selectedHelpType) {
                        ForEach(helpTypes, id: \.self) { helpType in
                            Text(helpType)
                                .font(.headline)
                        }
                    }
                    .pickerStyle(.menu)
                    .padding()
                    
                    if selectedHelpType == "Other" {
                        TextField("Enter Help Type", text: $otherHelpType)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                    }
                    
                    HStack {
                        Text("Day") // Custom label
                            .font(.headline)
                        
                        DatePicker("", selection: $selectedDate,in: nextDate..., displayedComponents: .date)
                            .labelsHidden()
                            .datePickerStyle(CompactDatePickerStyle())
                        
                        
                    }
                    
                    HStack {
                        Text("Time: ") // Custom label
                            .font(.headline)
                        
                        DatePicker("", selection: $selectedTime,displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .datePickerStyle(CompactDatePickerStyle())
                        
                    }
                    
                    HStack {
                        Text("Duration: ") // Custom label
                            .font(.headline)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 130, height: 40)
                            .foregroundColor(Color(.systemGray6))
                            .overlay(
                                Picker("Select Duration", selection: $selectedDuration) {
                                    ForEach(0..<20) { index in
                                        let duration = TimeInterval(index) * 15 * 60
                                        Text("\(duration.minutesToHoursMinutes())")
                                            .tag(duration)
                                    }
                                }.accentColor(.black)
                                    .pickerStyle(.menu)
                            )
                        
                    }
                    
                    



                            Button {
                                isShowingBookCompletionAlert = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    isShowingBookCompletionAlert = false
                                    isNavigatingToHomeView = true
                                    saveBookingToFirebase()
                                }
                            } label: {
                                Text("Book")
                                    .font(Font.custom("Alatsi", size: 20))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                            .padding()
                            .alert(isPresented: $isShowingBookCompletionAlert) {
                                Alert(
                                    title: Text("Book Completed!"),
                                    message: Text("Congratulations on completing the book!")
                                )
                                
                            }
                            .background(
                                NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true), isActive: $isNavigatingToHomeView) { EmptyView() }
                            )
                        
                    
                    
                }
            }

        }
        .padding()
    }
}

extension TimeInterval {
    func minutesToHoursMinutes() -> String {
        let hours = Int(self) / 3600
        let minutes = Int(self) % 3600 / 60
        return String(format: "%02d:%02d hr", hours, minutes)
    }
}
