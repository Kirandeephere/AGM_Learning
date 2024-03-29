//
//  WritingBaseView.swift
//  Project
//
//  Created by Kirandeep Kaur on 29/3/2024.
//

import SwiftUI
import Firebase

class Characters: ObservableObject {
    @Published var characters: [Character] = []

    init() {
        print("Call fetchCharacters")
        fetchCharacters()
    }

    func fetchCharacters() {
        let charactersRef = Database.database().reference().child("characters")
        print("Fetching character data from Firebase...")
        charactersRef.observeSingleEvent(of: .value) { (snapshot) in
            guard let characterDict = snapshot.value as? [String: Any] else {
                print("Unable to retrieve character data from snapshot.")
                return
            }
            
            var characters: [Character] = []
            
            for (characterKey, characterData) in characterDict {
                print("Processing character with key: \(characterKey)")
                
                if let characterData = characterData as? [String: Any],
                   let id = characterData["id"] as? Int,
                   let name = characterData["name"] as? String,
                   let image = characterData["image"] as? String,
                   let strokeOrderImagesData = characterData["strokeOrderImages"] as? [String] {
                    
                    let strokeOrderImages = strokeOrderImagesData.sorted(by: { $0 < $1 })
                    
                    let character = Character(id: id, name: name, image: image, strokeOrderImages: strokeOrderImages, expectedPath: [])
                    characters.append(character)
                    
                    print("Character with key '\(characterKey)' successfully retrieved.")
                } else {
                    print("Error retrieving character with key '\(characterKey)'.")
                    if let characterData = characterData as? [String: Any] {
                        print("Character data: \(characterData)")
                    } else {
                        print("Invalid character data format.")
                    }
                }
            }
            self.characters = characters
            print("Character data successfully fetched. Total characters: \(characters.count)")
        }
    }
}

struct Character: Identifiable {
    let id: Int
    let name: String
    let image: String
    let strokeOrderImages: [String]?
    var expectedPath: [Path]
}

struct WritingBaseView: View {
    @StateObject private var characters = Characters()
    @State private var selectedCharacter: Character?

    var body: some View {
        NavigationView {
            List(characters.characters) { character in
                Button(action: {
                    selectedCharacter = character
                }) {
                    Text(character.name)
                }
            }
            .navigationTitle("Characters")
            .sheet(item: $selectedCharacter) { character in
                CharacterOptionsView(character: character, characters: characters)
            }
        }
    }
}

struct CharacterOptionsView: View {
    let character: Character
    @ObservedObject var characters: Characters

    @State private var showStrokeOrder = false
    @State private var writeCharUser = false
    @State private var writeCharAdmin = false

    var selectedCharacterExpectedPath: Binding<[Path]> {
        Binding(
            get: {
                characters.characters.first { $0.id == character.id }?.expectedPath ?? []
            },
            set: { newValue in
                if let index = characters.characters.firstIndex(where: { $0.id == character.id }) {
                    characters.characters[index].expectedPath = newValue
                }
            }
        )
    }

    var body: some View {
        VStack {
            Text(character.name)
                .font(.headline)
                .padding()

            Button(action: {
                showStrokeOrder.toggle()
            }) {
                Text("Show Stroke Order")
            }
            .sheet(isPresented: $showStrokeOrder) {
                ShowStrokeOrderView(strokeOrderImages: character.strokeOrderImages!, dismissAction: {
                    showStrokeOrder = false
                })
            }

            Button(action: {
                writeCharUser.toggle()
            }) {
                Text("Write Character (User)")
            }
            .sheet(isPresented: $writeCharUser) {
                WriteCharUserView(character: character, expectedPath: selectedCharacterExpectedPath, dismissAction: {
                    writeCharUser = false
                })
            }

            Button(action: {
                writeCharAdmin.toggle()
            }) {
                Text("Write Character (Admin)")
            }
            .sheet(isPresented: $writeCharAdmin) {
                WriteCharAdminView(character: character, expectedPath: selectedCharacterExpectedPath, dismissAction: {
                    writeCharAdmin = false
                })
            }
        }
    }
}

#Preview {
    WritingBaseView()
}
