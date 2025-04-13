import SwiftUI

@Observable
@MainActor
class ChatPresenter {
    
    private let interactor: ChatInteractor
    private let router: ChatRouter
    
    private(set) var chatMessages: [ChatMessageModel] = ChatMessageModel.mocks
    private(set) var currentUser: UserModel? = .mock
   
    var textFieldText: String = ""
    var scrollPosition: String?
    
    init(interactor: ChatInteractor, router: ChatRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func onViewAppear(delegate: ChatDelegate) {
        interactor.trackScreenEvent(event: Event.onAppear(delegate: delegate))
    }
    
    func onViewDisappear(delegate: ChatDelegate) {
        interactor.trackEvent(event: Event.onDisappear(delegate: delegate))
    }
    
    func onSendMessagePressed() {
        guard let currentUser else { return }
        
        let content = textFieldText
        
        Task {
            do {
//                try TextValidationHelper.checkIfTextIsValid(text: content)
                
                let newChatMessage = AIChatModel(role: .user, content: content)
                
                let message = ChatMessageModel(
                    id: UUID().uuidString,
                    chatId: UUID().uuidString,
//                    authorId: currentUser.userId,
                    content: newChatMessage,
                    seenByIds: nil,
                    dateCreated: .now
                )
                chatMessages.append(message)
                
                scrollPosition = message.id
                
                textFieldText = ""
                
                let aiChats = chatMessages.compactMap({ $0.content })
                
//                let response = try await aiManager.generateText(chats: aiChats)
                let response = AIChatModel(role: .system, content: "This is a response from AI")
                let newAIMessage = ChatMessageModel(
                    id: UUID().uuidString,
                    chatId: UUID().uuidString,
//                    authorId: avatarId,
                    content: response,
                    seenByIds: nil,
                    dateCreated: .now
                )
                chatMessages.append(newAIMessage)

            } catch {
//                showAlert = AnyAppAlert(error: error)
            }
        }
    }
}

extension ChatPresenter {
    
    enum Event: LoggableEvent {
        case onAppear(delegate: ChatDelegate)
        case onDisappear(delegate: ChatDelegate)

        var eventName: String {
            switch self {
            case .onAppear:                 return "ChatView_Appear"
            case .onDisappear:              return "ChatView_Disappear"
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            case .onAppear(delegate: let delegate), .onDisappear(delegate: let delegate):
                return delegate.eventParameters
//            default:
//                return nil
            }
        }
        
        var type: LogType {
            switch self {
            default:
                return .analytic
            }
        }
    }

}
