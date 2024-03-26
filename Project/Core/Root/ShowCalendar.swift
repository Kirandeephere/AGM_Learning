//
//  ShowCalendar.swift
//  Project
//
//  Created by Gursewak Singh on 26/3/2024.
//

import SwiftUI

struct ShowCalendar: View {
    let calendar = Calendar.current
    @State private var selectedDate: Date = Date()
    
    var body: some View {
        VStack {
          
            HStack {
                Text(monthYearText(for: selectedDate))
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button(action: {
                    selectedDate = calendar.date(byAdding: .month, value: -1, to: selectedDate)!
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                
                Button(action: {
                    selectedDate = calendar.date(byAdding: .month, value: 1, to: selectedDate)!
                }) {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
            }
            .padding(.horizontal, 16)
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 16) {
                ForEach(monthDays(), id: \.self) { day in
                    Text("\(calendar.component(.day, from: day))")
                        .frame(width: 40, height: 40)
                        .background(day.isToday ? Color.green : Color.clear)
                        .cornerRadius(20)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
    }
    
    
    func monthDays() -> [Date] {
            guard let monthInterval = calendar.dateInterval(of: .month, for: selectedDate) else {
                return []
            }
            
            let startDate = monthInterval.start
            let endDate = monthInterval.end
            
            var dates: [Date] = []
            
            calendar.enumerateDates(startingAfter: startDate, matching: DateComponents(hour: 0, minute: 0, second: 0), matchingPolicy: .nextTime) { (date, _, stop) in
                guard let date = date else {
                    return
                }
                
                if date < endDate {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
            
            return dates
        }
        
        func monthYearText(for date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM yyyy"
            return dateFormatter.string(from: date)
        }
    }

extension Date {
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
}


#Preview {
    ShowCalendar()
}
