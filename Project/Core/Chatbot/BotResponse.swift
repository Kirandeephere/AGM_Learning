//
//  BotResponse.swift
//  Project
//
//  Created by Kirandeep Kaur on 23/3/2024.
//

import Foundation

func getBotResponse(message: String) -> String {
    let tempMessage = message.lowercased()
    
    if tempMessage.contains("hello") || tempMessage.contains("hi"){
        return "Hey there!"
    } else if tempMessage.contains("goodbye") {
        return "Talk to you later!"
    } else if tempMessage.contains("how are you") {
        return "I'm fine, how about you?"
    } else if tempMessage.contains("create essay") {
        return "Sure! What is the topic of your essay?"
    } else if tempMessage.contains("japanese") {
        return "こんにちは！元気ですか？"
    } else if tempMessage.contains("english") {
        return "Hello! How are you?"
    } else if tempMessage.contains("portuguese") {
        return "Olá! Como você está?"
    } else if tempMessage.contains("ui/ux") {
        if tempMessage.contains("difference") {
            return "UI (User Interface) refers to the visual elements and layout of a product, while UX (User Experience) focuses on the overall experience and usability. UI design is about how things look and feel, while UX design is about how things work and how users interact with them."
        } else if tempMessage.contains("principles") {
            return "Some key principles of good UI/UX design include simplicity, consistency, clarity, and user-centricity. The design should be intuitive, visually appealing, and provide a seamless and enjoyable experience for the users."
        } else if tempMessage.contains("tools") {
            return "Popular UI/UX design tools include Sketch, Figma, Adobe XD, and InVision. These tools offer features for creating wireframes, prototypes, and collaborative design workflows."
        } else if tempMessage.contains("examples") {
            return "Some examples of successful UI/UX design in popular products include the clean and intuitive interfaces of Apple products, the user-friendly design of Google search, and the seamless mobile app experiences of Instagram and Airbnb."
        } else if tempMessage.contains("user-centered design") {
            return "User-centered design is an approach that involves understanding users' needs, preferences, and behaviors through research and iterative testing. It focuses on designing products that meet user requirements and provide positive experiences."
        } else if tempMessage.contains("challenges") {
            return "Common challenges in UI/UX design include balancing user expectations with business goals, designing for different devices and platforms, and incorporating accessibility considerations. Overcoming these challenges often requires collaboration, research, and continuous learning."
        } else if tempMessage.contains("best practices") {
            return "Some UI/UX design best practices include conducting user research, using consistent and intuitive navigation, optimizing performance and loading times, providing clear and concise feedback, and prioritizing accessibility and inclusivity."
        } else if tempMessage.contains("trends") {
            return "Current UI/UX design trends include dark mode interfaces, microinteractions, voice user interfaces, minimalistic and flat design styles, augmented reality (AR) and virtual reality (VR) experiences, and personalized and adaptive interfaces."
        } else {
            return "UI/UX stands for User Interface and User Experience. It involves designing and enhancing the visual and interactive aspects of a product to ensure a great user experience."
        }
    } else {
        return "I'm sorry, could you please clarify your question?"
    }
}


