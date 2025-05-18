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
    func listenForNewMessages(conversationId: String) -> AsyncThrowingStream<[ConversationMessageModel], Error>
    func getAllConversationsForUser(userId: String) async throws -> [ConversationModel]
    func getLastConversationMessage(conversationId: String) async throws -> ConversationMessageModel?
}
