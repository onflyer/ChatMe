//
//  MockConversationService.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 24. 4. 2025..
//

import Foundation

@MainActor
class MockConversationService: ConversationService {
    
    @Published var conversation: ConversationModel?
    @Published var conversations: [ConversationModel]
    @Published var chatMessages: [ConversationMessageModel]
    let delay: Double
    let showError: Bool
    private var streamMessagesListenerTask: Task<Void, Error>?
    private var streamConversationsListenerTask: Task<Void, Error>?
    
    init(
        conversation: ConversationModel = ConversationModel.mock,
        conversations: [ConversationModel] = ConversationModel.mocks,
        chatMessages: [ConversationMessageModel] = ConversationMessageModel.mocks,
        delay: Double = 0.0,
        showError: Bool = false
    ) {
        self.conversations = conversations
        self.chatMessages = chatMessages
        self.delay = delay
        self.showError = showError
    }
    
    private func tryShowError() throws {
        if showError {
            throw URLError(.unknown)
        }
    }
    
    func createNewConversation(conversation: ConversationModel) async throws {
        
    }
    
    func addConversationMessage(conversationId: String, message: ConversationMessageModel) {
        chatMessages.append(message)
    }
    
    func getMostRecentConversation(userId: String) async throws -> ConversationModel? {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()
        return conversations.first { message in
            message.userId == userId
        }
    }
    
    func getAllConversationsForUser(userId: String) async throws -> [ConversationModel] {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()
        return conversations
    }
    
     func streamConversationMessages(conversationId: String) -> AsyncThrowingStream<[ConversationMessageModel], Error> {
       AsyncThrowingStream { continuation in
            continuation.yield(chatMessages)
           
           streamMessagesListenerTask?.cancel()
           streamMessagesListenerTask =  Task {
               for try await message in $chatMessages.values  {
                    continuation.yield(message)
                }
            }
        }
     }
    
    func streamConversations(userId: String) async throws -> AsyncThrowingStream<[ConversationModel], Error> {
        AsyncThrowingStream { continuation in
            continuation.yield(conversations)
            
            streamConversationsListenerTask?.cancel()
            streamConversationsListenerTask = Task {
                for try await item in $conversations.values {
                    continuation.yield(item)
                }
            }
        }
    }
    
    func getLastConversationMessage(conversationId: String) async throws -> ConversationMessageModel? {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()
        return ConversationMessageModel.mocks.randomElement()
    }
    
    
    func deleteConversation(conversationId: String) async throws {
        
    }
    
    func deleteAllConversationsForUser(userId: String) async throws {
        
    }
    
    func reportChat(report: ConversationReportModel) async throws {

    }
    
    func getConversation(conversatonId: String) async throws -> ConversationModel? {
        return conversations.first { conversation in
            conversation.id == conversatonId
        }
    }
    
    func getConversationMessagesForSummary(conversationId: String) async throws -> [ConversationMessageModel] {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()
        return chatMessages
    }
    
    func updateMessageForStream(conversationId: String, messageId: String, message: AIChatModel) async throws {
        
    }
    
    func addTitleSummaryForConversation(conversationId: String, title: String) async throws {
        
    }
    
    func getConversationTitle(conversationId: String) async throws -> ConversationModel? {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()
        return ConversationModel.mocks.randomElement()
    }
    
    func streamConversation(conversatonId: String) -> AsyncThrowingStream<ConversationModel, Error> {
        AsyncThrowingStream { continuation in
            if let conversation {
                continuation.yield(conversation)
            }
            
            Task {
                for await value in $conversation.values {
                    if let value {
                        continuation.yield(value)
                    }
                }
            }
            
            
        }
    }
    
}
