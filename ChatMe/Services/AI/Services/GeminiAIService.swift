//
//  GeminiAIService.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 14. 4. 2025..
//

import Foundation
import GoogleGenerativeAI

struct GeminiAIService: AIService {
    
    let model = GenerativeModel(name: "gemini-2.0-flash-lite", apiKey: "AIzaSyAZGhMA7GKMvYODu4Wv5DwOeuORMUKb7tQ")
    
    func generateText(chats: [AIChatModel]) async throws -> AIChatModel {
        
        let chats = chats.compactMap {$0.toModelContent()}
        
        let response = try await model.generateContent(chats)
        guard let text = response.text else {
            throw URLError(.badServerResponse)
        }
        let model = AIChatModel(role: .assistant, content: text)
        return model
    }
    
    func generateTextStream(chats: [AIChatModel]) async throws -> AsyncThrowingStream<AIChatModel, Error> {
        
        let chats = chats.compactMap {$0.toModelContent()}
        
        let responseStream = model.generateContentStream(chats)
        
        let stream = AsyncThrowingStream<AIChatModel, Error> { continuation in
            responseStream.mapAsyncThrowingStream(responseStream) { modelContent in
                continuation.yield(AIChatModel(role: .assistant, content: modelContent.text!))
            }
        }
        
        return stream
        
    }
}
