//
//  AIManager.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 16. 4. 2025..
//

import SwiftUI

@MainActor
@Observable
class AIManager {
    
    private let service: AIService
    
    init(service: AIService) {
        self.service = service
    }
    
    func generateText(chats: [AIChatModel]) async throws -> AIChatModel {
        try await service.generateText(chats: chats)
    }
}
