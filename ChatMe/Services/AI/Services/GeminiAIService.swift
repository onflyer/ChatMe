//
//  GeminiAIService.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 14. 4. 2025..
//

import Foundation
import GoogleGenerativeAI

struct GeminiAIService: AIService {
    
    let model = GenerativeModel(name: "gemini-1.5-flash-latest", apiKey: "AIzaSyAZGhMA7GKMvYODu4Wv5DwOeuORMUKb7tQ")
    
    func generateText(chats: [AIChatModel]) async throws -> AIChatModel {
        
        let chats = chats.compactMap {$0.toModelContent()}
        
        let response = try await model.generateContent(chats)
        guard let text = response.text else {
            throw URLError(.badServerResponse)
        }
        let model = AIChatModel(role: .assistant, content: text)
        return model
    }
    
}
