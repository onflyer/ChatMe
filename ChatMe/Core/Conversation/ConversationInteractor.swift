import SwiftUI

@MainActor
protocol ConversationInteractor {
    func trackEvent(event: LoggableEvent)
    func trackScreenEvent(event: LoggableEvent)
    func generateText(chats: [AIChatModel]) async throws -> AIChatModel
//    func getAllConversationsForUser(userId: String) async throws -> [ConversationModel]
    func getAuthId() throws -> String
    func getLastConversationMessage(conversationId: String) async throws -> ConversationMessageModel?
    func deleteConversation(conversationId: String) async throws
    func deleteAllConversationsForUser(userId: String) async throws
    func streamConversations(userId: String) async throws -> AsyncThrowingStream<[ConversationModel], Error>
    func streamConversation(conversatonId: String) -> AsyncThrowingStream<ConversationModel, Error>
    func getMostRecentConversation(userId: String) async throws -> ConversationModel?
    func getConversation(conversationId: String) async throws -> ConversationModel?

}

extension CoreInteractor: ConversationInteractor { }
