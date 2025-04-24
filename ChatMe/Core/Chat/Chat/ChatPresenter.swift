import SwiftUI

@Observable
@MainActor
class ChatPresenter {
    
    private let interactor: ChatInteractor
    private let router: ChatRouter
    
    private(set) var chatMessages: [ChatMessageModel] = []
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
                let uid = try interactor.getAuthId()
                let newChatMessage = AIChatModel(role: .user, content: content)
                let chatId = UUID().uuidString
                let message = ChatMessageModel.newUserMessage(chatId: chatId, userId: uid, message: newChatMessage)
                chatMessages.append(message)
                
                scrollPosition = message.id
                
                textFieldText = ""
                
                let aiChats = chatMessages.compactMap({ $0.content })
                
                let response = try await interactor.generateText(chats: aiChats)
                
                // newAIMessage is with role of assistant
                let newAIMessage = ChatMessageModel.newAIMessage(chatId: chatId, avatarId: uid, message: response)
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
