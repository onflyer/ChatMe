import SwiftUI

@Observable
@MainActor
class ChatPresenter {
    
    private let interactor: ChatInteractor
    private let router: ChatRouter
    
    private(set) var chatMessages: [ConversationMessageModel] = []
    private(set) var currentUser: UserModel?
    private(set) var conversation: ConversationModel?
    private(set) var isGeneratingResponse: Bool = false
    private var streamMessagesListenerTask: Task<Void, Error>?
    
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
        streamMessagesListenerTask?.cancel()
        chatMessages.removeAll()
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
                
                guard let conversation else {
                    throw ChatViewError.noChat
                }
                
                //Create user chat
                let newChatMessage = AIChatModel(role: .user, content: content)
                let message = ConversationMessageModel.newUserMessage(chatId: conversation.id, userId: userId, message: newChatMessage)
                
                //Upload user chat
                try await interactor.addConversationMessage(conversationId: conversation.id, message: message)
                
                textFieldText = ""
                
                // generate AI response
                isGeneratingResponse = true
                
                //Typing indicator
                if isGeneratingResponse {
                    chatMessages.append(ConversationMessageModel(id: "forTypingIndicator", chatId: "forTypingIndicator", content: AIChatModel(role: .assistant, content: "typing...")))
                }
                
                let aiChats = chatMessages.compactMap({ $0.content })
                let response = try await interactor.generateText(chats: aiChats)
                
                // create new AI message
                let newAIMessage = ConversationMessageModel.newAIMessage(chatId: conversation.id, message: response)
                
                //upload new AI message
                try await interactor.addConversationMessage(conversationId: conversation.id, message: newAIMessage)
                
            } catch {
                router.showAlert(error: error)
            }
            isGeneratingResponse = false
        }
    }
    
    func onSettingsPressed() {
        router.showConfirmationDialog(title: "", subtitle: "What would you like to do") {
            AnyView(
                Group {
                    Button("Report User / Chat", role: .destructive) {
                        self.onReportChatPressed()
                    }
                    Button("Delete Chat", role: .destructive) {
                        self.onDeleteChatPressed()
                    }
                }
            )
        }
    }
    
    
    func onDeleteChatPressed() {
        Task {
            do {
                let conversationId = try getConversationId()
                try await interactor.deleteConversation(conversationId: conversationId)
                router.dismissScreen()
            } catch {
                print(error)
                router.showAlert(
                    title: "Something went wrong.",
                    subtitle: "Please check your internet connection and try again \(error)."
                )
            }
        }
    }
    
    func onReportChatPressed() {
        Task {
            do {
                let userId = try interactor.getAuthId()
                let conversationId = try getConversationId()
                try await interactor.reportChat(conversationId: conversationId, userId: userId)
                
                router.showAlert(
                    title: "🚨 Reported 🚨",
                    subtitle: "We will review the chat shortly. You may leave the chat at any time. Thanks for bringing this to our attention!"
                )
            } catch {
                router.showAlert(
                    title: "Something went wrong.",
                    subtitle: "Please check your internet connection and try again."
                )
            }
        }
    }
    
    
    func loadConversation(conversationId: String) async {
        do {
            conversation = try await interactor.getConversation(conversationId: conversationId)
            print("Loading conversation SUCCESS")
        } catch {
            print("Loading conversation FAILED")
            print(error)
        }
    }
    
    func messageIsCurrentUser(message: ConversationMessageModel) -> Bool {
        message.authorId == interactor.auth?.uid
    }
    
    func createNewConversation(userId: String) async throws -> ConversationModel {
        // create new conversation
        let newConversation = ConversationModel.new(userId: userId)
        try await interactor.createNewConversation(conversation: newConversation)
        
        defer {
            Task {
                await listenForConversationMessages()
            }
        }
        return newConversation
    }
    
    func listenForConversationMessages() async {
        
        do {
            let conversationId = try getConversationId()
            streamMessagesListenerTask?.cancel()
            streamMessagesListenerTask = Task {
                for try await value in interactor.streamConversationMessages(conversationId: conversationId) {
                    chatMessages = value.sortedByKeyPath(keyPath: \.dateCreatedCalculated, ascending: true)
                    print("messages listener success")
                    scrollPosition = chatMessages.last?.id
                }
            }
        } catch {
            print(error)
            print("listener for conversation messages failed")
        }
    }
    
    func getConversationId() throws -> String {
        guard let conversation else {
            throw ChatViewError.noChat
        }
        return conversation.id
    }
    
    func resetConversation() {
        conversation = nil
    }
    
    func messageIsDelayedTimestamp(message: ConversationMessageModel) -> Bool {
        let currentMessageDate = message.dateCreatedCalculated
        
        guard
            let index = chatMessages.firstIndex(where: { $0.id == message.id }),
            chatMessages.indices.contains(index - 1)
        else {
            return false
        }
        
        let previousMessageDate = chatMessages[index - 1].dateCreatedCalculated
        let timeDiff = currentMessageDate.timeIntervalSince(previousMessageDate)
        
        // Threshold = 60 seconds * 45 minutes
        let threshold: TimeInterval = 60 * 45
        return timeDiff > threshold
    }
    
    enum ChatViewError: Error {
        case noChat
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
