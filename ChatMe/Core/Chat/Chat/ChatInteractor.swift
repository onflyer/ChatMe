import SwiftUI

@MainActor
protocol ChatInteractor {
    var auth: UserAuthInfo? { get }
    var currentUser: UserModel? { get }
    func trackEvent(event: LoggableEvent)
    func trackScreenEvent(event: LoggableEvent)
    func getAuthId() throws -> String
    func generateText(chats: [AIChatModel]) async throws -> AIChatModel
    func generateTextStream(chats: [AIChatModel]) async throws -> AsyncThrowingStream<AIChatModel, Error>
    func createNewConversation(conversation: ConversationModel) async throws
    func addConversationMessage(conversationId: String, message: ConversationMessageModel) async throws
    func streamConversationMessages(conversationId: String) -> AsyncThrowingStream<[ConversationMessageModel], Error>
    func deleteConversation(conversationId: String) async throws
    func reportChat(conversationId: String, userId: String) async throws
    func getConversation(conversationId: String) async throws -> ConversationModel?

}

extension CoreInteractor: ChatInteractor { }
