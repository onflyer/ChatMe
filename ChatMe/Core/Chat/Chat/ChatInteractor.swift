import SwiftUI

@MainActor
protocol ChatInteractor {
    var auth: UserAuthInfo? { get }
    var currentUser: UserModel? { get }
    func trackEvent(event: LoggableEvent)
    func trackScreenEvent(event: LoggableEvent)
    func getAuthId() throws -> String
    func generateText(chats: [AIChatModel]) async throws -> AIChatModel
    func createNewConversation(conversation: ConversationModel) async throws
    func addConversationMessage(conversationId: String, message: ConversationMessageModel) async throws
    func getConversation(userId: String) async throws -> ConversationModel?
}

extension CoreInteractor: ChatInteractor { }
