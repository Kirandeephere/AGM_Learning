//
//  ChatBotView.swift
//  Project
//
//  Created by Kirandeep Kaur on 22/3/2024.

import SwiftUI
import Firebase
import FirebaseFirestore

struct ChatBotView: View {
    @State private var messageText = ""
    @State var messages: [ChatMessage] = []
    @State var showScrollView = false
    let db = Firestore.firestore()
    var chatID: String = UUID().uuidString // Generate a unique chat ID for each conversation
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                //header
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.clear)
                        .frame(width: 40, height: 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    
                    NavigationLink(
                        destination: ChatHistoryView().navigationBarHidden(true),
                        label: {
                            Image(systemName: "chevron.backward")
                                .font(Font.custom("Alatsi", size: 15))
                                .foregroundColor(Color(red: 0.08, green: 0.13, blue: 0.30))
                        })
                }.padding(.leading)
                
                Spacer()
                
                Text("Chatbot")
                    .font(.title)
                    .bold()
                
                Image("chatbot")
                    .resizable()
                    .frame(width: 80, height: 80)
                Spacer()
                
            }
            
            if showScrollView {
                ScrollView {
                    ForEach(messages, id: \.self) { chatMessage in
                        // If the message sender is the user
                        if chatMessage.sender == "user" {
                            // User message styles
                            HStack {
                                Spacer()
                                Text(chatMessage.message)
                                    .padding()
                                    .foregroundColor(Color.white)
                                    .background(Color.blue.opacity(0.8))
                                    .cornerRadius(10)
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 10)
                            }
                        } else {
                            // Bot message styles
                            HStack {
                                Text(chatMessage.message)
                                    .padding()
                                    .background(Color.gray.opacity(0.15))
                                    .cornerRadius(10)
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 10)
                                Spacer()
                            }
                        }
                    }.rotationEffect(.degrees(180))
                }
                .rotationEffect(.degrees(180))
                
            } else {
                VStack(spacing: 25) {
                    Spacer()
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 298, height: 68)
                            .foregroundColor(Color.gray.opacity(0.1))
                        Text("Answer all your questions.\n(Just ask me anything you like)")
                            .font(.subheadline)
                            .foregroundColor(Color(hex: 0xA6A7A6))
                            .multilineTextAlignment(.center)
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 298, height: 68)
                            .foregroundColor(Color.gray.opacity(0.1))
                        Text("Generate all the text you want\n(essay, article, report & more)")
                            .font(.subheadline)
                            .foregroundColor(Color(hex: 0xA6A7A6))
                            .multilineTextAlignment(.center)
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 298, height: 68)
                            .foregroundColor(Color.gray.opacity(0.1))
                        Text("Conversational AI\n(I can talk to you like a human being)")
                            .font(.subheadline)
                            .foregroundColor(Color(hex: 0xA6A7A6))
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                }
            }
            
            // Contains the Message bar
            HStack {
                TextField("Type something", text: $messageText)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .onSubmit {
                        sendMessage(message: messageText)
                    }
                
                Button {
                    sendMessage(message: messageText)
                } label: {
                    Image(systemName: "paperplane.fill")
                }
                .font(.system(size: 26))
                .padding(.horizontal, 10)
            }
            .padding()
        }
    }
    
    func sendMessage(message: String) {
        withAnimation {
            let userMessage = ChatMessage(sender: "user", message: message)
            messages.append(userMessage)
            self.messageText = ""
            showScrollView = true
            
            let chatData: [String: Any] = [
                "timestamp": Date(),
               "chatID": chatID, // Save the chat ID in the document
                "conversation": messages.map { message in
                    return [
                        "sender": message.sender,
                        "message": message.message
                    ]
                }
            ]
            
            db.collection("chats").document(chatID).setData(chatData) { error in
                if let error = error {
                    print("Error sending message: \(error.localizedDescription)")
                } else {
                    print("Message sent successfully")
                }
            }
            
            let botResponse = getBotResponse(message: message)
            let botMessage = ChatMessage(sender: "bot", message: botResponse)
            messages.append(botMessage)
            
            let botChatData: [String: Any] = [
                "timestamp": Date(),
                "chatID": chatID, // Save the chat ID in the document
                "conversation": [
                    [
                        "sender": botMessage.sender,
                        "message": botMessage.message
                    ]
                ]
            ]
            
            db.collection("chats").document(chatID).collection("messages").addDocument(data: botChatData) { error in
                if let error = error {
                    print("Error sending bot message: \(error.localizedDescription)")
                } else {
                    print("Bot message sent successfully")
                }
            }
        }
    }
}

struct ChatMessage: Hashable {
    var sender: String
    var message: String
}
#Preview {
    ChatBotView()
}