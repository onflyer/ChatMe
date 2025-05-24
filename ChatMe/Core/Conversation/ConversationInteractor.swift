import SwiftUI

@MainActor
protocol ConversationInteractor {
    func trackEvent(event: LoggableEvent)
    func trackScreenEvent(event: LoggableEvent)
    func getAllConversationsForUser(userId: String) async throws -> [ConversationModel]
    func getAuthId() throws -> String
    func getLastConversationMessage(conversationId: String) async throws -> ConversationMessageModel?
    func deleteConversation(conversationId: String) async throws
    func deleteAllConversationsForUser(userId: String) async throws
}

extension CoreInteractor: ConversationInteractor { }
