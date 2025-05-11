import SwiftUI

@MainActor
protocol ConversationInteractor {
    func trackEvent(event: LoggableEvent)
    func trackScreenEvent(event: LoggableEvent)
    func getAllConversationsForUser(userId: String) async throws -> [ConversationModel]
    func getAuthId() throws -> String
    func getLastConversationMessage(conversationId: String) async throws -> ConversationMessageModel?
}

extension CoreInteractor: ConversationInteractor { }
