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
                print("Completed item fetched from the database and saved:", characterId)
            } else {
                print("Invalid completed item value in the database.")
            }
        }
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
                                        RoundedRectangle(cornerRadius: 5)
                                            .frame(width: 28, height: 28)
                                            .foregroundColor(.gray)
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
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(hex: 0xbdbdbd), lineWidth: 1)
                        .frame(width: 360, height: 150)
                        .foregroundColor(.clear)
                        .overlay(
                            VStack(alignment: .leading){
                                Text("French Basic").font(.callout.bold()).padding(.top)
                                
                                HStack{
                                    RoundedRectangle(cornerRadius: 5).frame(width: 28, height: 28).foregroundColor(.gray)
                                    Text("In the lessons we leran new words.")
                                }
                                
                                VStack (alignment: .center){
                                    ZStack(alignment: .leading){
                                        RoundedRectangle(cornerRadius: 5).frame(width: 331, height: 10).foregroundColor(Color(hex: 0xdcdcdc))
                                        
                                        RoundedRectangle(cornerRadius: 5).frame(width: 200, height: 10).foregroundColor(Color.brown)
                                    }.padding(.top)
                                    
                                    Text("Completed 10 of 12")
                                }
                                
                                
                                Spacer()
                            }.padding(.leading)
                        ).padding(.bottom)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(hex: 0xbdbdbd), lineWidth: 1)
                        .frame(width: 360, height: 150)
                        .foregroundColor(.clear)
                        .overlay(
                            VStack(alignment: .leading){
                                Text("100 Essential Grammar").font(.callout.bold()).padding(.top)
                                
                                HStack{
                                    RoundedRectangle(cornerRadius: 5).frame(width: 28, height: 28).foregroundColor(.gray)
                                    Text("In the lessons we leran new words.")
                                }
                                
                                VStack (alignment: .center){
                                    ZStack(alignment: .leading){
                                        RoundedRectangle(cornerRadius: 5).frame(width: 331, height: 10).foregroundColor(Color(hex: 0xdcdcdc))
                                        
                                        RoundedRectangle(cornerRadius: 5).frame(width: 200, height: 10).foregroundColor(Color.blue)
                                    }.padding(.top)
                                    
                                    Text("Completed 08 of 12")
                                }
                                
                                
                                Spacer()
                            }.padding(.leading)
                        ).padding(.bottom)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(hex: 0xbdbdbd), lineWidth: 1)
                        .frame(width: 360, height: 150)
                        .foregroundColor(.clear)
                        .overlay(
                            VStack(alignment: .leading){
                                Text(" Essential Chinese").font(.callout.bold()).padding(.top)
                                
                                HStack{
                                    RoundedRectangle(cornerRadius: 5).frame(width: 28, height: 28).foregroundColor(.pink)
                                    Text("In the lessons we leran new words.")
                                }
                                
                                VStack (alignment: .center){
                                    ZStack(alignment: .leading){
                                        RoundedRectangle(cornerRadius: 5).frame(width: 331, height: 10).foregroundColor(Color(hex: 0xdcdcdc))
                                        
                                        RoundedRectangle(cornerRadius: 5).frame(width: 200, height: 10).foregroundColor(Color.yellow)
                                    }.padding(.top)
                                    
                                    Text("Completed 05 of 12")
                                }
                                
                                
                                Spacer()
                            }.padding(.leading)
                        ).padding(.bottom)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(hex: 0xbdbdbd), lineWidth: 1)
                        .frame(width: 360, height: 150)
                        .foregroundColor(.clear)
                        .overlay(
                            VStack(alignment: .leading){
                                Text("English Grammar").font(.callout.bold()).padding(.top)
                                
                                HStack{
                                    RoundedRectangle(cornerRadius: 5).frame(width: 28, height: 28).foregroundColor(.black)
                                    Text("In the lessons we leran new words.")
                                }
                                
                                VStack (alignment: .center){
                                    ZStack(alignment: .leading){
                                        RoundedRectangle(cornerRadius: 5).frame(width: 331, height: 10).foregroundColor(Color(hex: 0xdcdcdc))
                                        
                                        RoundedRectangle(cornerRadius: 5).frame(width: 200, height: 10).foregroundColor(Color(hex: 0xa92028))
                                    }.padding(.top)
                                    
                                    Text("Completed 01 of 12")
                                }
                                
                                
                                Spacer()
                            }.padding(.leading)
                        ).padding(.bottom)
                    
                    
                    
                }

            }.padding(.horizontal)
                    
        }
        .onAppear {
                fetchCompletedItemForCourse()
            }
       
                    
            }
        }
