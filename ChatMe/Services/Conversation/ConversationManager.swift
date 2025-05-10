//
//  ConversationManager.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 24. 4. 2025..
//

import Foundation

@MainActor
@Observable
class ConversationManager {
    
    let service: ConversationService
    
    init(service: ConversationService) {
        self.service = service
    }
    
    func createNewConversation(conversation: ConversationModel) async throws {
        try await service.createNewConversation(conversation: conversation)
    }
    
    func addConversationMessage(conversationId: String, message: ConversationMessageModel) async throws {
        try await service.addConversationMessage(conversationId: conversationId, message: message)
    }
    
    func getConversation(userId: String) async throws -> ConversationModel? {
        try await service.getConversation(userId: userId)
    }

}
