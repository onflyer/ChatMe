import SwiftUI

@MainActor
protocol ConversationRouter {
    func showChatView(delegate: ChatDelegate)
}

extension CoreRouter: ConversationRouter { }
