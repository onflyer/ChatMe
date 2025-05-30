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
    
    func updateMessageForStream(conversationId: String, messageId: String, message: AIChatModel) async throws {
        try await service.updateMessageForStream(conversationId: conversationId, messageId: messageId, message: message)
    }
    
    func addTitleSummaryForConversation(conversationId: String, title: String) async throws {
        try await service.addTitleSummaryForConversation(conversationId: conversationId, title: title)
    }
    
    func getMostRecentConversation(userId: String) async throws -> ConversationModel? {
        try await service.getMostRecentConversation(userId: userId)
    }
    
    func getConversation(conversatonId: String) async throws -> ConversationModel? {
        try await service.getConversation(conversatonId: conversatonId)
    }

    func streamConversationMessages(conversationId: String) -> AsyncThrowingStream<[ConversationMessageModel], Error> {
        service.streamConversationMessages(conversationId: conversationId)
    }
        
    func streamConversations(userId: String) async throws -> AsyncThrowingStream<[ConversationModel], Error> {
        try await service.streamConversations(userId: userId)
    }
    
    func getAllConversationsForUser(userId: String) async throws -> [ConversationModel] {
        try await service.getAllConversationsForUser(userId: userId)
    }
    
    func getLastConversationMessage(conversationId: String) async throws -> ConversationMessageModel? {
        try await service.getLastConversationMessage(conversationId: conversationId)
    }
    
    func deleteConversation(conversationId: String) async throws {
        try await service.deleteConversation(conversationId: conversationId)
    }
    
    func deleteAllConversationsForUser(userId: String) async throws {
        try await service.deleteAllConversationsForUser(userId: userId)
    }
    
    func reportChat(conversationId: String, userId: String) async throws {
        let report = ConversationReportModel.new(conversationId: conversationId, userId: userId)
        try await service.reportChat(report: report)
    }
    
    func getConversationMessagesForSummary(conversationId: String) async throws -> [ConversationMessageModel] {
        try await service.getConversationMessagesForSummary(conversationId: conversationId)
    }
}
