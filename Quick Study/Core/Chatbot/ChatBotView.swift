//
//  ChatBotView.swift
//  Project
//
//  Created by Kirandeep Kaur on 22/3/2024.

import SwiftUI

struct ChatBotView: View {
    @State private var messageText = ""
    @State var messages: [ChatMessage] = []
    @State var showScrollView = false
    @EnvironmentObject var viewModel: AuthViewModel
    var user: User? {
        viewModel.currentUser
    }
    
    var body: some View {
        NavigationView{
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
                            destination: HomeView().navigationBarHidden(true),
                            label: {
                                Image(systemName: "chevron.backward")
                                    .font(Font.custom("Alatsi-Regular", size: 15))
                                    .foregroundColor(Color(hex: 0x14214C))
                            })
                    }.padding(.leading)
                    
                    Spacer()
                    
                    Text("Chatbot")
                        .font(Font.custom("Alatsi-Regular", size: 25))
                        .foregroundColor(Color(hex: 0x14214C))
                    
                    Image("chatbot")
                        .resizable()
                        .frame(width: 80, height: 80)
                    Spacer()
                    
                }
                
                if showScrollView {
                    ScrollView(showsIndicators: false){
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
                                .foregroundColor(Color(hex: 0xF7F7F7))
                            Text("Answer all your questions.\n(Just ask me anything you like)")
                                .font(.subheadline)
                                .foregroundColor(Color(hex: 0xA6A7A6))
                                .multilineTextAlignment(.center)
                        }
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 298, height: 68)
                                .foregroundColor(Color(hex: 0xF7F7F7))
                            Text("Generate all the text you want\n(essay, article, report & more)")
                                .font(.subheadline)
                                .foregroundColor(Color(hex: 0xA6A7A6))
                                .multilineTextAlignment(.center)
                        }
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 298, height: 68)
                                .foregroundColor(Color(hex: 0xF7F7F7))
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
    }
    
    func sendMessage(message: String) {
        withAnimation {
            guard let user = viewModel.currentUser else {
                print("User is not authenticated.")
                return
            }
            
            let userMessage = ChatMessage(sender: "user", message: message)
            messages.append(userMessage)
            self.messageText = ""
            showScrollView = true
            
    
                        
            let botResponse = getBotResponse(message: message)
            let botMessage = ChatMessage(sender: "bot", message: botResponse)
            messages.append(botMessage)
            
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
