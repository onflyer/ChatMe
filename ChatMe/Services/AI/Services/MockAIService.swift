//
//  MockAIService.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 16. 4. 2025..
//

import Foundation

struct MockAIService: AIService {
    
    func generateText(chats: [AIChatModel]) async throws -> AIChatModel {
        try await Task.sleep(for: .seconds(1))
        return AIChatModel(role: .system, content: "This is returned text from the AI.")
    }
    
    func generateTextStream(chats: [AIChatModel]) async throws -> AsyncThrowingStream<AIChatModel, any Error> {
        AsyncThrowingStream { continuation in
            continuation.yield(AIChatModel(role: .assistant, content: "This is the first part of returned text from AI"))
            continuation.yield(AIChatModel(role: .assistant, content: "This is the second part of returned text from AI"))
            continuation.yield(AIChatModel(role: .assistant, content: "This is the third part of returned text from AI"))
            
        }
    }
    
    
    
    
}
