import SwiftUI

@MainActor
protocol ConversationRouter {
    func showChatView(delegate: ChatDelegate)
    func showStreamChatView(delegate: StreamChatDelegate)
    func showAlert(error: Error)
}

extension CoreRouter: ConversationRouter { }
