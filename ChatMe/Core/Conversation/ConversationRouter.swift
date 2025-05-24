import SwiftUI

@MainActor
protocol ConversationRouter {
    func showChatView(delegate: ChatDelegate)
    func showAlert(error: Error)
}

extension CoreRouter: ConversationRouter { }
