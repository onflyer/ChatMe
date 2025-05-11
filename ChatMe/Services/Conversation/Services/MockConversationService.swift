//
//  MockConversationService.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 24. 4. 2025..
//

import Foundation

struct MockConversationService: ConversationService {
    func createNewConversation(conversation: ConversationModel) async throws {
        
    }
    
    func addConversationMessage(conversationId: String, message: ConversationMessageModel) {
        
    }
    
    func getConversation(userId: String) async throws -> ConversationModel? {
        ConversationModel.mock
    }
    
    func streamConversationMessages(conversationId: String) -> AsyncThrowingStream<[ConversationMessageModel], Error> {
        AsyncThrowingStream { continuation in
            
        }
    }
    
    func getAllConversationsForUser(userId: String) async throws -> [ConversationModel] {
        ConversationModel.mocks
    }
    
    func getLastConversationMessage(conversationId: String) async throws -> ConversationMessageModel? {
        ConversationMessageModel.mocks.randomElement()
    }
    
    
}
