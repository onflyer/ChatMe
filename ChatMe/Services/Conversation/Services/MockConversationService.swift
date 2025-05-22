//
//  MockConversationService.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 24. 4. 2025..
//

import Foundation

@MainActor
class MockConversationService: ConversationService {
    
    let conversations: [ConversationModel]
    @Published var chatMessages: [ConversationMessageModel]
    let delay: Double
    let showError: Bool
    private var streamMessagesListenerTask: Task<Void, Error>?
    
    init(
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
           
           Task {
               for try await message in $chatMessages.values  {
                    continuation.yield(message)
                }
            }
        }
     }
    
    func getLastConversationMessage(conversationId: String) async throws -> ConversationMessageModel? {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()
        return ConversationMessageModel.mocks.randomElement()
    }
    
    
}
