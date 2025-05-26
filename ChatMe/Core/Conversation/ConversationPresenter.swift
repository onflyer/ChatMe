import SwiftUI

@Observable
@MainActor
class ConversationPresenter {
    
    private let interactor: ConversationInteractor
    private let router: ConversationRouter
    
    private(set) var conversations: [ConversationModel] = []
    private(set) var lastMessageModel: ConversationMessageModel?
    private(set) var lastMessage: String?
    private(set) var isLoadingChats: Bool = true
    private var conversationsListenerTask: Task<Void, Error>?

    
    init(interactor: ConversationInteractor, router: ConversationRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func onViewAppear(delegate: ConversationDelegate) {
        interactor.trackScreenEvent(event: Event.onAppear(delegate: delegate))
    }
    
    func onViewDisappear(delegate: ConversationDelegate) {
        interactor.trackEvent(event: Event.onDisappear(delegate: delegate))
        conversationsListenerTask?.cancel()

    }
    
    func onConversationPressed(conversationId: String) {
        let delegate = ChatDelegate(conversationId: conversationId)
        router.showChatView(delegate: delegate)
    }
    
    func deleteConversation(conversationId: String) async {
        do {
            try await interactor.deleteConversation(conversationId: conversationId)
        } catch {
            print(error)
            router.showAlert(error: error)
        }
    }
    
    func onConversationSettingsPressed() {
        Task {
            do {
                let userId = try interactor.getAuthId()
                try await interactor.deleteAllConversationsForUser(userId: userId)
            } catch {
                print("Failed to delete chats")
                router.showAlert(error: error)
            }
        }
    }
    
    func listenForConversations() async {
        
        do {
            let userId = try interactor.getAuthId()
            conversationsListenerTask?.cancel()
            conversationsListenerTask = Task {
                for try await value in try await interactor.streamConversations(userId: userId) {
                    conversations = value.sortedByKeyPath(keyPath: \.dateCreatedCalculated, ascending: true)
                    print("Stream conversations success")
                }
            }
        } catch {
            print(error)
            print("STREAM FAILED")
        }
    }
    
    
    func loadChats() async {
        do {
            let userId = try interactor.getAuthId()
            conversations = try await interactor.getAllConversationsForUser(userId: userId)
                .sortedByKeyPath(keyPath: \.dateModified, ascending: false)
        } catch {
            print("Failed to load chats")
            router.showAlert(error: error)
           

        }
    }
    
    func loadLastMessage(conversationId: String) async {
        do {
            lastMessageModel = try await interactor.getLastConversationMessage(conversationId: conversationId)
            lastMessage = lastMessageModel?.content?.message ?? "No message"
        } catch {
            print(error)
            print("Failed to load last message")
        }
    }
    
    func onSwipeToDeleteAction(at offsets: IndexSet) {
        offsets.forEach { index in
            let conversation = conversations[index]
            Task {
                await deleteConversation(conversationId: conversation.id)
            }
        }
    }
    

}

extension ConversationPresenter {
    
    enum Event: LoggableEvent {
        case onAppear(delegate: ConversationDelegate)
        case onDisappear(delegate: ConversationDelegate)

        var eventName: String {
            switch self {
            case .onAppear:                 return "ConversationView_Appear"
            case .onDisappear:              return "ConversationView_Disappear"
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
