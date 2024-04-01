//
//  ReviewView.swift
//  Project
//
//  Created by Kirandeep Kaur on 22/3/2024.
//

import SwiftUI
import Firebase

struct ReviewView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var completeditems: Int = 0
    @State private var gotocourseview = false

    var user: User? {
        viewModel.currentUser
    }
    
    //fetch the progess of Japanses Course
    private func fetchCompletedItemForCourse() {
        guard let user = viewModel.currentUser else {
            print("User is not authenticated.")
            return
        }
        
        let database = Database.database().reference()
        let completedItemsRef = database.child("Course").child(user.id).child("completedItems")
        
        completedItemsRef.observeSingleEvent(of: .value) { snapshot, error in
            if let error = error {
                print("Error fetching completed item:", error)
                return
            }
            
            if let characterId = snapshot.value as? Int {
                self.completeditems = characterId
                //print("DEBUG: Completed item fetched from the database and saved:", characterId)
            } else {
                print("Invalid completed item value in the database.")
            }
        }
    }
    
    struct DummyCourse {
        let Course: String
        let info: String
        let image: String
        let completed: Int
        let total: Int
    }
    
    let items = [
        DummyCourse(Course: "Introduction to English Grammar", info: "Learn the fundamentals of English grammar.", image: "english_image", completed: 3, total: 10),
        DummyCourse(Course: "Conversational Spanish", info: "Improve your Spanish speaking skills through practical conversations.", image: "spanish_image", completed: 18, total: 20),
        DummyCourse(Course: "French Pronunciation", info: "Master the correct pronunciation of French words and phrases.", image: "french_image", completed: 7, total: 15),
        DummyCourse(Course: "German Grammar Essentials", info: "Explore the key grammar rules and structures in the German language.", image: "german_image", completed: 12, total: 15),
        DummyCourse(Course: "Introduction to Mandarin Chinese", info: "Get started with the basics of Mandarin Chinese, including tones and characters.", image: "mandarin_image", completed: 5, total: 10)
    ]
    
    func getWidth(completed: Int, total: Int) -> CGFloat {
        let maxWidth: CGFloat = 331 // Maximum width of the rounded rectangle
        let progress = CGFloat(completed) / CGFloat(total)
        let width = maxWidth * progress
        return width
    }
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                
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
                    
                    
                    Text("Review")
                        .font(Font.custom("Alatsi", size: 25))
                        .foregroundColor(Color(red: 0.078, green: 0.13, blue: 0.30))
                        .padding(.leading, 100)
                        
                }.padding(.bottom)
                
                Text("Your Progress").font(.headline.bold()) .padding(.bottom)
                
                ScrollView(showsIndicators: false){
                    
                    NavigationLink(destination: HiraganaLessonView().navigationBarBackButtonHidden(true), isActive: $gotocourseview) {
                        EmptyView()
                    }
                    
                    if(completeditems != 0){
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(hex: 0xbdbdbd), lineWidth: 1)
                            .frame(width: 360, height: 150)
                            .foregroundColor(.clear)
                            .overlay(
                                VStack(alignment: .leading) {
                                    Text("Hiragana Lesson 01")
                                        .font(.callout.bold())
                                        .padding(.top)
                                    
                                    HStack {
                                        Image("hiragana_image")
                                             .resizable()
                                             .frame(width: 28, height: 28)
                                             .cornerRadius(5)
                                         
                                        Text("Learning the 5 vowels in Japanese Hiragana!")
                                    }
                                    
                                    VStack(alignment: .center) {
                                        ZStack(alignment: .leading) {
                                            RoundedRectangle(cornerRadius: 5)
                                                .frame(width: 331, height: 10)
                                                .foregroundColor(Color(hex: 0xdcdcdc))
                                            
                                            RoundedRectangle(cornerRadius: 5)
                                                .frame(width: CGFloat(completeditems) / 10 * 331, height: 10)
                                                .foregroundColor(Color(hex: 0xa92028))
                                        }
                                        .padding(.top)
                                        
                                        Text("Completed \(completeditems) of 10")
                                    }
                                    
                                    Spacer()
                                }
                                    .padding(.leading)
                            )
                            .padding(.bottom)
                            .onTapGesture {
                                // Handle the tap gesture here
                                gotocourseview = true
                            }
                    }
                    
                    ScrollView{
                        ForEach(items, id: \.Course) { item in
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(hex: 0xbdbdbd), lineWidth: 1)
                                .frame(width: 360, height: 150)
                                .foregroundColor(.clear)
                                .overlay(
                                    VStack(alignment: .leading){
                                        Text(item.Course).font(.callout.bold()).padding(.top)
                                        
                                        HStack{
                                            Image(item.image)
                                                 .resizable()
                                                 .frame(width: 28, height: 28)
                                                 .cornerRadius(5)
                                            
                                            Text(item.info)
                                                .font(.caption)
                                        }
                                        
                                        VStack(alignment: .center) {
                                            ZStack(alignment: .leading) {
                                                RoundedRectangle(cornerRadius: 5)
                                                    .frame(width: 331, height: 10)
                                                    .foregroundColor(Color(hex: 0xdcdcdc))
                                                
                                                RoundedRectangle(cornerRadius: 5)
                                                    .frame(width: getWidth(completed: item.completed, total: item.total), height: 10)
                                                    .foregroundColor(Color(hex: 0xa92028))
                                            }
                                            .padding(.top)
                                            
                                            Text("Completed \(item.completed) of \(item.total)")
                                        }
                                        
                                        
                                        Spacer()
                                    }.padding(.leading)
                                ).padding(.bottom)
                        }
                    }

                }

            }.padding(.horizontal)
                    
        }.onAppear {
            fetchCompletedItemForCourse()
        }
    
    }
}
