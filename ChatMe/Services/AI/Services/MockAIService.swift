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
    
    
}
