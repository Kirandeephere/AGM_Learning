//
//  HiraganaLessonView.swift
//  Project
//
//  Created by Gursewak Singh on 28/3/2024.
//

import SwiftUI
import Firebase

class CharacterManager {
    static let shared = CharacterManager() // Singleton instance
    
    private var characters: [Character] = []
    
    func fetchCharacters(completion: @escaping ([Character]) -> Void) {
        let charactersRef = Database.database().reference().child("characters")
        print("Fetching character data from Firebase...")
        charactersRef.observeSingleEvent(of: .value) { (snapshot) in
            guard let characterDict = snapshot.value as? [String: Any] else {
                print("Unable to retrieve character data from snapshot.")
                completion([])
                return
            }
            
            var characters: [Character] = []
            
            for (characterKey, characterData) in characterDict {
                print("Processing character with key: \(characterKey)")
                
                if let characterData = characterData as? [String: Any],
                   let id = characterData["id"] as? Int,
                   let name = characterData["name"] as? String,
                   let image = characterData["image"] as? String,
                   let strokeOrderImagesData = characterData["strokeOrderImages"] as? [String],
                   let dotsImage = characterData["dotsimage"] as? String {
                    
                    let strokeOrderImages = strokeOrderImagesData.sorted(by: { $0 < $1 })
                    
                    let character = Character(id: id, name: name, image: image, strokeOrderImages: strokeOrderImages, expectedPath: [], dotsImage: dotsImage)
                    characters.append(character)
                    
                    print("Character with key '\(characterKey)' successfully retrieved.")
                } else {
                    print("Error retrieving character with key '\(characterKey)'.")
                    if let characterData = characterData as? [String: Any] {
                        //print("Character data: \(characterData)")
                    } else {
                        print("Invalid character data format.")
                    }
                }
            }
            
            self.characters = characters
            print("Character data successfully fetched. Total characters: \(characters.count)")
            completion(characters) // Pass the fetched characters to the completion handler
        }
    }
    
    func getAllCharacters() -> [Character] {
        return characters
    }
}

struct HiraganaLessonView: View {
    @State private var selectedTask: String = "Start Lesson 1" //Selected by default
    @ObservedObject var charactersadmin: Characters = Characters()
    @State private var completeditems: Int = 0
    @State private var characters: [Character] = []
    @State private var showStrokeOrder = false
    @State private var showAdminView = false
    @State private var selectedCharacter: Character
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showimage: Int = 0
    

    var user: User? {
        viewModel.currentUser
    }
    
        init() {
            let defaultValue = Character(id: 1, name: "一", image: "yi", strokeOrderImages: ["yi_1", "yi"], expectedPath: [], dotsImage: "a_dots")
            _selectedCharacter = State(initialValue: defaultValue)
        }
    
    private func fetchCompletedItemFromDatabase() {
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
        if let user = viewModel.currentUser {
            VStack(alignment: .leading){
                //Back Button
                HStack{
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.clear)
                            .frame(width: 40, height: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                        
                        NavigationLink(
                            destination: HiraganaStartView().navigationBarHidden(true),
                            label: {
                                Image(systemName: "chevron.backward")
                                    .font(Font.custom("Alatsi", size: 15))
                                    .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                            })
                        
                    }.padding(.top, 30).padding(.bottom, 30)
                    
                    Spacer()
                }
                
                //Lesson Info
                VStack(alignment: .leading, spacing: 15){
                    Text("Hiragana Lesson 01")
                        .font(.title2.bold())
                        .foregroundColor(Color(hex: 0x430c0f))
                    
                    Text("Learn the 5 vowels in Japanese")
                        .font(.headline.bold())
                        .foregroundColor(Color(hex: 0x7b2126))
                    
                    HStack(spacing: 30){
                        
                        HStack{
                            Rectangle()
                                .frame(width: 35, height: 35)
                                .foregroundColor(Color(hex: 0xfccccf))
                                .cornerRadius(5)
                                .overlay(
                                    Image(systemName: "clock.fill")
                                        .foregroundColor(Color(hex: 0x7b2126))
                                )
                            
                            Text("30 mins")
                                .font(.headline.bold())
                            
                        }
                        
                        HStack{
                            Rectangle()
                                .frame(width: 35, height: 35)
                                .foregroundColor(Color(hex: 0xfccccf))
                                .cornerRadius(5)
                                .overlay(
                                    Image(systemName: "person.3.fill")
                                        .foregroundColor(Color(hex: 0x7b2126))
                                )
                            
                            Text("455 students")
                                .font(.headline.bold())
                            
                        }
                    }
                }.padding(.bottom, 30)
                
                if user.id == "IzDrg0lkazfGwq70FUpSe49yTwA3"{
                    Button(action: {
                        showAdminView = true // Activate the navigation link
                    }) {
                        Text("Edit Expected Path For Characters")
                            .font(.headline.bold())
                            .padding(.leading)
                            .foregroundColor(.red)
                            .padding(.bottom)
                    }
                    
                }
                
                // Char List
                ScrollView(showsIndicators: false){
                    VStack(alignment: .leading){
                        // Vowel 1
                        Group{
                            HStack{
                                Rectangle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color(hex: 0xfccccf))
                                    .cornerRadius(5)
                                    .overlay(
                                        Image(systemName: "play.fill")
                                            .foregroundColor(Color(hex: 0x7b2126))
                                        
                                    )
                                
                                
                                Button(action: {
                                    selectedCharacter = characters.first(where: { $0.id == 1 })! // Find the character with id = 1
                                    showStrokeOrder = true // Activate the navigation link
                                }) {
                                    Text("Vowel 1")
                                        .font(.headline.bold())
                                        .padding(.leading)
                                        .foregroundColor(Color(hex:0x7b2126))
                                }
                                
                            }
                            HStack {
                                Rectangle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(completeditems < 1 ? Color(hex: 0xf6f6f6) : Color(hex: 0xfccccf))
                                    .cornerRadius(5)
                                    .overlay(
                                        Image(systemName: "play.fill")
                                            .foregroundColor(completeditems < 1 ? Color.gray : Color(hex:0x7b2126))
                                    )
                                
                                Button(action: {
                                    selectedCharacter = characters.first(where: { $0.id == 1 })! // Find the character with id = 1
                                    showStrokeOrder = true // Activate the navigation link
                                    showimage = 1
                                }) {
                                    Text("Challenge 1")
                                        .font(.headline.bold())
                                        .padding(.leading)
                                        .foregroundColor(completeditems < 1 ? Color.gray : Color(hex:0x7b2126))
                                }
                                .disabled(completeditems < 1)
                                
                            }
                        }
                        
                        // Vowel 2
                        Group{
                            HStack{
                                Rectangle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(completeditems < 2 ? Color(hex: 0xf6f6f6) : Color(hex: 0xfccccf))
                                    .cornerRadius(5)
                                    .overlay(
                                        Image(systemName: "play.fill")
                                            .foregroundColor(completeditems < 2 ? Color.gray : Color(hex: 0x7b2126))
                                        
                                    )
                                
                                Button(action: {
                                    if let character = characters.first(where: { $0.id == 2 }) {
                                        selectedCharacter = character
                                        showStrokeOrder = true
                                        showimage = 2
                                    } else {
                                        // Handle the case when the character with id 1 is not found
                                        print("Character with id 2 not found.")
                                    } // Activate the navigation link
                                }) {
                                    Text("Vowel 2")
                                        .font(.headline.bold()).padding(.leading)
                                        .foregroundColor(completeditems < 2 ? Color.gray : Color(hex:0x7b2126))
                                }.disabled(completeditems < 2)
                                
                                
                            }
                            HStack {
                                Rectangle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(completeditems < 3 ? Color(hex: 0xf6f6f6) : Color(hex: 0xfccccf))
                                    .cornerRadius(5)
                                    .overlay(
                                        Image(systemName: "play.fill")
                                            .foregroundColor(completeditems < 3 ? Color.gray : Color(hex: 0x7b2126))
                                    )
                                
                                Button(action: {
                                    selectedCharacter = characters.first(where: { $0.id == 2 })! // Find the character with id = 1
                                    showStrokeOrder = true // Activate the navigation link
                                    showimage = 3
                                }) {
                                    Text("Challenge 2")
                                        .font(.headline.bold())
                                        .padding(.leading)
                                        .foregroundColor(completeditems < 3 ? Color.gray : Color(hex:0x7b2126))
                                }.disabled(completeditems < 3)
                            }
                        }
                        
                        // Vowel 3
                        Group{
                            HStack{
                                Rectangle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(completeditems < 4 ? Color(hex: 0xf6f6f6) : Color(hex: 0xfccccf))
                                    .cornerRadius(5)
                                    .overlay(
                                        Image(systemName: "play.fill")
                                            .foregroundColor(completeditems < 4 ? Color.gray : Color(hex: 0x7b2126))
                                        
                                    )
                                
                                Button(action: {
                                    if let character = characters.first(where: { $0.id == 3 }) {
                                        selectedCharacter = character
                                        showStrokeOrder = true
                                        showimage = 2
                                    } else {
                                        // Handle the case when the character with id 1 is not found
                                        print("Character with id 3 not found.")
                                    } // Activate the navigation link
                                }) {
                                    Text("Vowel 3")
                                        .font(.headline.bold()).padding(.leading)
                                        .foregroundColor(completeditems < 4 ? Color.gray : Color(hex:0x7b2126))
                                }.disabled(completeditems < 4)
                                
                                
                            }
                            HStack {
                                Rectangle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(completeditems < 5 ? Color(hex: 0xf6f6f6) : Color(hex: 0xfccccf))
                                    .cornerRadius(5)
                                    .overlay(
                                        Image(systemName: "play.fill")
                                            .foregroundColor(completeditems < 5 ? Color.gray : Color(hex: 0x7b2126))
                                    )
                                
                                Button(action: {
                                    selectedCharacter = characters.first(where: { $0.id == 3 })! // Find the character with id = 1
                                    showStrokeOrder = true // Activate the navigation link
                                    showimage = 3
                                }) {
                                    Text("Challenge 3")
                                        .font(.headline.bold())
                                        .padding(.leading)
                                        .foregroundColor(completeditems < 5 ? Color.gray : Color(hex:0x7b2126))
                                }.disabled(completeditems < 5)
                            }
                        }
                        
                        // Vowel 4
                        Group{
                            HStack{
                                Rectangle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(completeditems < 6 ? Color(hex: 0xf6f6f6) : Color(hex: 0xfccccf))
                                    .cornerRadius(5)
                                    .overlay(
                                        Image(systemName: "play.fill")
                                            .foregroundColor(completeditems < 6 ? Color.gray : Color(hex: 0x7b2126))
                                        
                                    )
                                
                                Button(action: {
                                    if let character = characters.first(where: { $0.id == 4 }) {
                                        selectedCharacter = character
                                        showStrokeOrder = true
                                        showimage = 2
                                    } else {
                                        // Handle the case when the character with id 1 is not found
                                        print("Character with id 4 not found.")
                                    } // Activate the navigation link
                                }) {
                                    Text("Vowel 4")
                                        .font(.headline.bold()).padding(.leading)
                                        .foregroundColor(completeditems < 6 ? Color.gray : Color(hex:0x7b2126))
                                }.disabled(completeditems < 6)
                                
                                
                            }
                            HStack {
                                Rectangle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(completeditems < 7 ? Color(hex: 0xf6f6f6) : Color(hex: 0xfccccf))
                                    .cornerRadius(5)
                                    .overlay(
                                        Image(systemName: "play.fill")
                                            .foregroundColor(completeditems < 7 ? Color.gray : Color(hex: 0x7b2126))
                                    )
                                
                                Button(action: {
                                    selectedCharacter = characters.first(where: { $0.id == 4 })! // Find the character with id = 1
                                    showStrokeOrder = true // Activate the navigation link
                                    showimage = 3
                                }) {
                                    Text("Challenge 4")
                                        .font(.headline.bold())
                                        .padding(.leading)
                                        .foregroundColor(completeditems < 7 ? Color.gray : Color(hex:0x7b2126))
                                }.disabled(completeditems < 7)
                            }
                        }
                        
                        // Vowel 5
                        Group{
                            HStack{
                                Rectangle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(completeditems < 8 ? Color(hex: 0xf6f6f6) : Color(hex: 0xfccccf))
                                    .cornerRadius(5)
                                    .overlay(
                                        Image(systemName: "play.fill")
                                            .foregroundColor(completeditems < 8 ? Color.gray : Color(hex: 0x7b2126))
                                        
                                    )
                                
                                Button(action: {
                                    if let character = characters.first(where: { $0.id == 5 }) {
                                        selectedCharacter = character
                                        showStrokeOrder = true
                                        showimage = 2
                                    } else {
                                        // Handle the case when the character with id 1 is not found
                                        print("Character with id 5 not found.")
                                    } // Activate the navigation link
                                }) {
                                    Text("Vowel 5")
                                        .font(.headline.bold()).padding(.leading)
                                        .foregroundColor(completeditems < 8 ? Color.gray : Color(hex:0x7b2126))
                                }.disabled(completeditems < 8)
                                
                                
                            }
                            HStack {
                                Rectangle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(completeditems < 9 ? Color(hex: 0xf6f6f6) : Color(hex: 0xfccccf))
                                    .cornerRadius(5)
                                    .overlay(
                                        Image(systemName: "play.fill")
                                            .foregroundColor(completeditems < 9 ? Color.gray : Color(hex: 0x7b2126))
                                    )
                                
                                Button(action: {
                                    selectedCharacter = characters.first(where: { $0.id == 5 })! // Find the character with id = 1
                                    showStrokeOrder = true // Activate the navigation link
                                    showimage = 9
                                }) {
                                    Text("Challenge 5")
                                        .font(.headline.bold())
                                        .padding(.leading)
                                        .foregroundColor(completeditems < 9 ? Color.gray : Color(hex:0x7b2126))
                                }.disabled(completeditems < 9)
                            }
                        }
                        
                        
                        
                    }.padding(.leading, 20)
                }
                
                // Navigate to ShowStrokeOrderView when a character is selected
                NavigationLink(destination: WritingBaseView( characters: charactersadmin), isActive: $showAdminView) {
                    EmptyView()
                }
                
                
                NavigationLink(destination: ShowStrokeOrderView(character: selectedCharacter, strokeOrderImages: selectedCharacter.strokeOrderImages ?? [], characters: charactersadmin, selectedImage: $showimage).navigationBarHidden(true), isActive: $showStrokeOrder) {
                    EmptyView()
                }
                
            }.padding(.leading, 20)
                .onAppear {
                    CharacterManager.shared.fetchCharacters { fetchedCharacters in
                        self.characters = fetchedCharacters
                        selectedCharacter = fetchedCharacters.first(where: { $0.id == 1 })!
                        
                        fetchCompletedItemFromDatabase()
                    }
                }
        }
        
    }
}

