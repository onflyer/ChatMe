//
//  ChatStreamPresenter.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 30. 5. 2025..
//

import SwiftUI

@Observable
@MainActor
class ChatStreamPresenter {
    
    private let interactor: ChatInteractor
    private let router: ChatRouter
    
    private(set) var chatMessages: [ConversationMessageModel] = []
    private(set) var currentUser: UserModel?
    private(set) var conversation: ConversationModel?
    private(set) var isGeneratingResponse: Bool = false
    private var streamMessagesListenerTask: Task<Void, Error>?
    
    var textFieldText: String = ""
    var streamTextResponse: AIChatModel = .init(role: .assistant, content: "")
    var scrollPosition: String?
    
    init(interactor: ChatInteractor, router: ChatRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func onViewAppear(delegate: StreamChatDelegate) {
        interactor.trackScreenEvent(event: Event.onAppear(delegate: delegate))
        currentUser = interactor.currentUser
    }
    
    func onViewDisappear(delegate: StreamChatDelegate) {
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
                                
                let aiChats = chatMessages.compactMap({ $0.content })
                let responseStream = try await interactor.generateTextStream(chats: aiChats)
                let newAIMessage = ConversationMessageModel.newAIMessage(chatId: conversation.id, message: AIChatModel(role: .assistant, content: ""))
                let nextMessage = ConversationMessageModel.newAIMessage(chatId: conversation.id, message: AIChatModel(role: .assistant, content: ""))
                                
                do {
                    streamTextResponse.message.removeAll()
                    try await interactor.addConversationMessage(conversationId: conversation.id, message: nextMessage)

                    for try await message in responseStream {
                        streamTextResponse.message.append(message.message)

                        try await interactor.updateMessageForStream(conversationId: conversation.id, messageId: chatMessages.last!.id, message: streamTextResponse)
                    }
               
                } catch {
                    print(error)
                    router.showAlert(error: error)
                }
            } catch {
                router.showAlert(error: error)
            }
            isGeneratingResponse = false
            
        }
    }
    
    func onSettingsPressed() {
        router.showAlert(.confirmationDialog, title: "", subtitle: "What would you like to do?") {
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
                    .alert,
                    title: "Something went wrong.",
                    subtitle: "Please check your internet connection and try again \(error).",
                    buttons: nil
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
                    .alert,
                    title: "🚨 Reported 🚨",
                    subtitle: "We will review the chat shortly. You may leave the chat at any time. Thanks for bringing this to our attention!",
                    buttons: nil
                )
            } catch {
                router.showAlert(
                    .alert,
                    title: "Something went wrong.",
                    subtitle: "Please check your internet connection and try again.",
                    buttons: nil
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

extension ChatStreamPresenter {
    
    enum Event: LoggableEvent {
        case onAppear(delegate: StreamChatDelegate)
        case onDisappear(delegate: StreamChatDelegate)
        
        var eventName: String {
            switch self {
            case .onAppear:                 return "StreamChatView_Appear"
            case .onDisappear:              return "StreamChatView_Disappear"
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
