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
    
    var body: some View {
        NavigationView {
            VStack{
                List(chats) { chat in
                    NavigationLink(destination: ChatDetailView(chat: chat)) {
                        VStack(alignment: .leading) {
                            Text(chat.firstQuestion)
                                .font(.headline)
                            Text(chat.formattedTimestamp)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onAppear(perform: fetchChats)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Spacer()
                        
                        HStack {
                            NavigationLink(
                                destination: HomeView().navigationBarHidden(true),
                                label: {
                                    Image(systemName: "chevron.backward")
                                        .font(Font.custom("Alatsi", size: 15))
                                        .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                                })
                            
                            Text("Chat History")
                                .font(.headline)
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        NavigationLink(
                            destination: ChatBotView().navigationBarHidden(true),
                            label: {
                                Text("New Chat").font(.headline)
                            })
                    }
                }
                
            }
        }
    }
    
    func fetchChats() {
        db.collection("chats").getDocuments { querySnapshot, error in
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
