//
//  ConversationService.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 24. 4. 2025..
//

import Foundation

protocol ConversationService: Sendable {
    func createNewConversation(conversation: ConversationModel) async throws
    func addConversationMessage(conversationId: String, message: ConversationMessageModel) async throws
    func getMostRecentConversation(userId: String) async throws -> ConversationModel?
    func streamConversationMessages(conversationId: String) -> AsyncThrowingStream<[ConversationMessageModel], Error>
    func getAllConversationsForUser(userId: String) async throws -> [ConversationModel]
    func getLastConversationMessage(conversationId: String) async throws -> ConversationMessageModel?
    func deleteConversation(conversationId: String) async throws
    func deleteAllConversationsForUser(userId: String) async throws
    func reportChat(report: ConversationReportModel) async throws
    func streamConversations(userId: String) async throws -> AsyncThrowingStream<[ConversationModel], Error>
    func getConversation(conversatonId: String) async throws -> ConversationModel?
    func getConversationMessagesForSummary(conversationId: String) async throws -> [ConversationMessageModel]
    func updateMessageForStream(conversationId: String, messageId: String, message: AIChatModel) async throws 
}
