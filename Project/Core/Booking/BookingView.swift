//
//  BookingView.swift
//  Project
//
//  Created by Kirandeep Kaur on 24/3/2024.
//

import SwiftUI
import Firebase

extension TimeInterval {
    func minutesToHoursMinutes() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.hour, .minute]
        return formatter.string(from: self) ?? ""
    }
}

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
        guard let user = viewModel.currentUser else { return }
        
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
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Booking Details")
                .font(.largeTitle)
                .padding()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    bookingDetail(title: "Name", value: name)
                    bookingDetail(title: "Subject", value: subject)
                    
                    Spacer()

                    // Description Feild
                    TextField("Description", text: $description)
                        .textFieldStyle(.plain)
                        .padding()
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: 350, minHeight: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.horizontal, 10)
                        .offset(x: 10)

                    Spacer()

                    // Dropdown for Seclection
                    Picker("Help Type", selection: $selectedHelpType) {
                        ForEach(helpTypes, id: \.self) { helpType in
                            Text(helpType)
                                .font(.headline)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(maxWidth: 350, minHeight: 50)
                    .padding(.horizontal, 20)
                    .background(Color(.systemGray5))
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
                    .foregroundColor(.gray)

                    Spacer()
                    
                    if selectedHelpType == "Other" {
                        TextField("Enter Help Type", text: $otherHelpType)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                    }
                    
                    
                    //Date Time and Duration Stack
                    HStack {
                        VStack {
                            dateTimePicker(title: "Day", date: $selectedDate, components: .date)
                                .fixedSize()

                            dateTimePicker(title: "Time", date: $selectedTime, components: .hourAndMinute)
                                .fixedSize()

                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(Color(.systemGray6))
                        )
                        
                        
                        VStack {
                            Text("Duration")
                                .font(.headline)
                                .padding(.bottom, 4)
                            
                        
                        Picker("Select Duration", selection: $selectedDuration) {
                                        ForEach(0..<20) { index in
                                            let duration = TimeInterval(index) * 15 * 60
                                            Text("\(duration.minutesToHoursMinutes())")
                                                .tag(duration)
                                        }
                                    }
                                    .fixedSize()
                                    .pickerStyle(MenuPickerStyle())
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .foregroundColor(Color(.systemGray5))
                                    )
                        }
                        .padding()
                        .background(
                        RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Color(.systemGray6))
                        )
            
                        
                    }
                    .padding()
                    
                    
                    //Book Button
                    Button(action: {
                        isShowingBookCompletionAlert = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isShowingBookCompletionAlert = false
                            isNavigatingToHomeView = true
                            saveBookingToFirebase()
                        }
                    }) {
                        Text("Book")
                            .font(Font.custom("Alatsi", size: 20))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .offset(x: 140)
                    .padding()
                    .alert(isPresented: $isShowingBookCompletionAlert) {
                        Alert(
                            title: Text("Book Completed!"),
                            message: Text("Congratulations on completing the book!")
                        )
                    }
                    .background(
                        NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true), isActive: $isNavigatingToHomeView) {
                            EmptyView()
                        }
                    )
                }
                .padding()
            }
        }
    }
    
    private func bookingDetail(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .padding(.horizontal, 20)

            
            Text(value)
                .font(.subheadline)
                .foregroundColor(.gray)
                .frame(width: 350, height: 50)
                .background(Color(.systemGray5))
                .cornerRadius(8)
                .padding(.horizontal, 20)
        }
    }
    
    private func dateTimePicker(title: String, date: Binding<Date>, components: DatePickerComponents) -> some View {
        HStack {
            Text("\(title): ") // Custom label
                .font(.headline)
            
            DatePicker("", selection: date, displayedComponents: components)
                .labelsHidden()
                .datePickerStyle(CompactDatePickerStyle())
        }
    }
}


struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        //Dummy test data to preview
        BookingView(name: "Chan Tai Man", subject: "Computer Science")
            .environmentObject(AuthViewModel())
    }
}
