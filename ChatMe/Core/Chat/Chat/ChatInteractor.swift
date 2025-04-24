import SwiftUI

@MainActor
protocol ChatInteractor {
    func trackEvent(event: LoggableEvent)
    func trackScreenEvent(event: LoggableEvent)
    func getAuthId() throws -> String
    func generateText(chats: [AIChatModel]) async throws -> AIChatModel
}

extension CoreInteractor: ChatInteractor { }
