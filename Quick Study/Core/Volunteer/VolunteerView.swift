//
//  VolunteerView.swift
//  Project
//
//  Created by Kirandeep Kaur on 22/3/2024.
//

import SwiftUI

struct VolunteerView: View {
    @StateObject var viewModel = VolunteerViewModel()
    @State private var selectedUniversity = ""
    @State private var selectedMajor = ""
    
    var body: some View {
        NavigationView{
            VStack (alignment: .leading){
                
                // Header
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.clear)
                            .frame(width: 40, height: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                        
                        NavigationLink(
                            destination: HomeView().navigationBarHidden(true),
                            label: {
                                Image(systemName: "chevron.backward")
                                    .font(Font.custom("Alatsi", size: 15))
                                    .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                            })
                    }
                    
                    
                    Text("Volunteers")
                        .font(Font.custom("Alatsi", size: 25))
                        .foregroundColor(Color(red: 0.078, green: 0.13, blue: 0.30))
                        
                }
                
                //filtering
                HStack {
                    
                    Text("Filter by:")
                        .font(Font.custom("Alatsi", size: 18))
                        .padding([.top,.trailing])
                    
                    
                    Menu {
                        Button("All Universities") { selectedUniversity = "" }
                        ForEach(getUniqueUniversities(), id: \.self) { university in
                            Button(action: { selectedUniversity = university }) {
                                Text(truncateTextIfNeeded(text: university, maxLength: 20))
                                    .multilineTextAlignment(.center)
                            }
                        }
                    } label: {
                        Text(truncateTextIfNeeded(text: selectedUniversity.isEmpty ? "All Universities " : selectedUniversity, maxLength: 20))
                            .multilineTextAlignment(.center)
                            .frame(width: 120, alignment: .leading) // Set a fixed frame width
                        
                    }
                    .frame(height: 10)
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .padding(.top)
                    
                    
                    Menu {
                        Button("All Majors") { selectedMajor = "" }
                        ForEach(getUniqueMajors(), id: \.self) { major in
                            Button(action: { selectedMajor = major }) {
                                Text(major)
                            }
                        }
                    } label: {
                        Text(selectedMajor.isEmpty ? "All Majors " : selectedMajor)
                            .frame(width: 80, alignment: .leading) // Set a fixed frame width
                        
                    }
                    .frame(height: 10)
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .padding(.leading,10)
                    .padding(.top)
                    
                    
                }
                
                
                VStack {
                    if !viewModel.listVolunteer.isEmpty {
                        ScrollView {
                            VStack(alignment: .leading) {
                                ForEach(viewModel.listVolunteer.filter { volunteer in
                                    (selectedUniversity.isEmpty || volunteer.University == selectedUniversity) &&
                                    (selectedMajor.isEmpty || volunteer.Major == selectedMajor)
                                }) { object in
                                    Button(action: {
                                        viewModel.selectedVolunteer = object
                                    }) {
                                        HStack(alignment: .center) {
                                            Text(getInitials(from: object.Name))
                                                .font(.title)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                                .frame(width: 60, height: 60)
                                                .background(Color(red: 0.66, green: 0.13, blue: 0.16))
                                                .clipShape(Circle())
                                                .padding(.leading)
                                            
                                            VStack(alignment: .leading) {
                                                Text(object.Name)
                                                    .font(Font.custom("Alatsi", size: 25))
                                                    .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                                                Group {
                                                    Text("# \(object.ID)")
                                                    Text(object.University)
                                                    Text(object.Major)
                                                }
                                                .font(Font.custom("Alatsi", size: 16))
                                                .foregroundColor(.black)
                                            }
                                            .padding()
                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .background(NavigationLink(
                                        destination: VolunteerDetailView(volunteer: object).navigationBarHidden(true),
                                        isActive: Binding(
                                            get: { viewModel.selectedVolunteer == object },
                                            set: { newValue in
                                                if !newValue {
                                                    viewModel.selectedVolunteer = nil
                                                }
                                            }
                                        )
                                    ) {
                                        EmptyView()
                                    })
                                    Divider()
                                }
                            }
                        }
                    }
                }
                .onAppear {
                    viewModel.ListVolunteer()
                }
            }.padding(.leading)
        }
        
    }
    
    // Helper function to truncate text if needed
    private func truncateTextIfNeeded(text: String, maxLength: Int) -> String {
        if text.count <= maxLength {
            return text
        } else {
            let index = text.index(text.startIndex, offsetBy: maxLength - 3)
            return text[..<index] + "..."
        }
    }
    
    // Helper function to get initials from a name
    private func getInitials(from name: String) -> String {
        let initials = name
            .split(separator: " ")
            .prefix(2)
            .map { String($0.first ?? Swift.Character("")) }
            .joined()
            .uppercased()
        return initials
    }
    
    // Helper function to get unique universities from the viewModel.listVolunteer array
    private func getUniqueUniversities() -> [String] {
        let universities = Set(viewModel.listVolunteer.map { $0.University })
        return Array(universities)
    }
    
    // Helper function to get unique majors from the viewModel.listVolunteer array
    private func getUniqueMajors() -> [String] {
        let majors = Set(viewModel.listVolunteer.map { $0.Major })
        return Array(majors)
    }
}

#Preview {
    VolunteerView()
}
