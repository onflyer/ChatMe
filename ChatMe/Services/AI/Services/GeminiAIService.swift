//
//  GeminiAIService.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 14. 4. 2025..
//

import Foundation
import GoogleGenerativeAI

struct GeminiAIService {
    
    let model = GenerativeModel(name: "gemini-1.5-flash-latest", apiKey: "AIzaSyAZGhMA7GKMvYODu4Wv5DwOeuORMUKb7tQ")
    
    func generateText(chats: AIChatModel) async throws -> AIChatModel {
        
        let prompt = chats.message
        
        let response = try await model.generateContent(prompt)
        
        let chat = AIChatModel(role: .system, content: response.text!)
        return chat
    }
    
}
