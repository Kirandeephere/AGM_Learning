//
//  ChatHistoryView.swift
//  Project
//
//  Created by Kirandeep Kaur on 23/3/2024.
//
import SwiftUI
import Firebase
import FirebaseFirestore

struct ChatDetailView: View {
    let chat: Chat

    
    var body: some View {
        VStack {
            Text("Chat Detail View")
                .navigationBarTitle(chat.firstQuestion)
        }
    }
    
}



struct Message: Identifiable {
    let id: String
    let text: String
}

struct Chat: Identifiable {
    let id: String
    let firstQuestion: String
    let timestamp: Date
    
    var formattedTimestamp: String {
        let dateFormatter = DateFormatter()
        
        if Calendar.current.isDateInToday(timestamp) {
            dateFormatter.timeStyle = .short
        } else {
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
        }
        
        return dateFormatter.string(from: timestamp)
    }
}


#Preview {
    ChatHistoryView()
}






struct ChatHistoryView: View {
    @State var chats: [Chat] = []
    let db = Firestore.firestore()
    
    @State private var selectedButton: Int = 0

    
    
    var groupedChats: [String: [Chat]] {
        switch selectedButton {
        case 0:
            return Dictionary(grouping: chats) { chat in
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                return dateFormatter.string(from: chat.timestamp)
            }
        default:
            return [:]
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // Header Group
                Group {
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
                                        .font(Font.custom("Alatsi-Regular", size: 15))
                                        .foregroundColor(Color(hex: 0x14214C))
                                })
                        }
                        .padding(20)
                        
                        Text("History")
                            .font(Font.custom("Alatsi-Regular", size: 25))
                            .foregroundColor(Color(hex: 0x14214C))
                            .offset(x: 70, y: 0)
                        
                        Spacer()
                        
                        Button(action: {
                            // Handle search icon action
                        }) {
                            Image(systemName: "magnifyingglass")
                                .font(Font.system(size: 20))
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Button Group
                HStack {
                    Button(action: {
                        withAnimation {
                            selectedButton = 0
                        }
                        // Handle Chat button action
                    }) {
                        Text("Chat")
                            .font(Font.custom("Alatsi-Regular", size: 20))
                            .foregroundColor(.white)
                            .padding()
                            .background(selectedButton == 0 ? Color.blue : Color.gray.opacity(0.5))
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        withAnimation {
                            selectedButton = 1
                        }
                        // Handle Pinned button action
                    }) {
                        Text("Pinned")
                            .font(Font.custom("Alatsi-Regular", size: 20))
                            .foregroundColor(.white)
                            .padding()
                            .background(selectedButton == 1 ? Color.green : Color.gray.opacity(0.5))
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        withAnimation {
                            selectedButton = 2
                        }
                        // Handle Shared button action
                    }) {
                        Text("Shared")
                            .font(Font.custom("Alatsi-Regular", size: 20))
                            .foregroundColor(.white)
                            .padding()
                            .background(selectedButton == 2 ? Color.orange : Color.gray.opacity(0.5))
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                
                
                if selectedButton == 0 {
                    ScrollView {
                        VStack {
                            ForEach(groupedChats.keys.sorted().reversed(), id: \.self) { dateKey in
                                Section(header: Text(dateKey)) {
                                    ForEach(groupedChats[dateKey]!) { chat in
                                        NavigationLink(destination: ChatDetailView(chat: chat)) {
                                            VStack(alignment: .leading) {
                                                Text(chat.firstQuestion)
                                                    .font(.headline)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                Text(chat.formattedTimestamp)
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                    }
                                }
                                .padding(.vertical, 5) // Adjust the padding value as desired
                                
                            }
                        }
                        .padding(.horizontal, 50)
                    }
                    .onAppear(perform: fetchChats)
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            NavigationLink(
                                destination: ChatBotView().navigationBarHidden(true),
                                label: {
                                    Text("New Chat").font(.headline)
                                })
                        }
                    }
                }
                else{
                    Text("No data for this view.")
                        .foregroundColor(.red)
                }
                
        }
    }
}
        
    
    func fetchChats() {
        db.collection("chats").order(by: "timestamp", descending: true).addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error fetching chats: \(error.localizedDescription)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No chats found")
                return
            }
            
            chats = documents.compactMap { document in
                guard let firstQuestion = document.data()["conversation"] as? [[String: Any]],
                      let timestamp = document.data()["timestamp"] as? Timestamp
                else {
                    return nil
                }
                
                let chatID = document.documentID
                let firstQuestionMessage = firstQuestion.first?["message"] as? String
                
                return Chat(id: chatID, firstQuestion: firstQuestionMessage ?? "", timestamp: timestamp.dateValue())
            }
        }
    }
}
