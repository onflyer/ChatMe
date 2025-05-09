import SwiftUI

@Observable
@MainActor
class ChatPresenter {
    
    private let interactor: ChatInteractor
    private let router: ChatRouter
    
    private(set) var chatMessages: [ConversationMessageModel] = []
    private(set) var currentUser: UserModel?
    private(set) var conversation: ConversationModel?

    var textFieldText: String = ""
    var scrollPosition: String?
    
    init(interactor: ChatInteractor, router: ChatRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func onViewAppear(delegate: ChatDelegate) {
        interactor.trackScreenEvent(event: Event.onAppear(delegate: delegate))
        currentUser = interactor.currentUser
    }
    
    func onViewDisappear(delegate: ChatDelegate) {
        interactor.trackEvent(event: Event.onDisappear(delegate: delegate))
    }
    
    func messageIsCurrentUser(message: ConversationMessageModel) -> Bool {
        message.authorId == interactor.auth?.uid
    }
    
    func createNewConversation(userId: String) async throws -> ConversationModel {
        // create new conversation
        let newConversation = ConversationModel.new(userId: userId)
        try await interactor.createNewConversation(conversation: newConversation)
        return newConversation
    }
    
    func onSendMessagePressed() {
        
        let content = textFieldText
        
        Task {
            do {
                //Get userId
                let userId = try interactor.getAuthId()
                
                //If chat is nil, then create a new chat
                if conversation == nil {
                    conversation = try await createNewConversation(userId: userId)
                }
                
                let newChatMessage = AIChatModel(role: .user, content: content)
                let chatId = UUID().uuidString
                let message = ConversationMessageModel.newUserMessage(chatId: chatId, userId: userId, message: newChatMessage)
                chatMessages.append(message)
                
                scrollPosition = message.id
                
                textFieldText = ""
                
                let aiChats = chatMessages.compactMap({ $0.content })
                
                let response = try await interactor.generateText(chats: aiChats)
                
                // newAIMessage is with role of assistant
                let newAIMessage = ConversationMessageModel.newAIMessage(chatId: chatId, message: response)
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
