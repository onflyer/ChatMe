import SwiftUI

struct ConversationDelegate {
    var eventParameters: [String: Any]? {
        nil
    }
}

struct ConversationView: View {
    
    @State var presenter: ConversationPresenter
    let delegate: ConversationDelegate
    
    var body: some View {
        List {
            ForEach(presenter.conversations) { conversation in
                ConversationRowView(headline: conversation.id, subheadline: presenter.lastMessage, hasNewChat: false)
                    .task {
                        await presenter.loadLastMessage(conversationId: conversation.id)
                    }
            }
            .removeListRowFormatting()
            
           
        }
        .navigationTitle("Conversations")
        .task {
            await presenter.loadChats()
        }
        .onAppear {
            presenter.onViewAppear(delegate: delegate)
        }
        .onDisappear {
            presenter.onViewDisappear(delegate: delegate)
        }
    }
}

#Preview {
    let container = DevPreview.shared.container()
    let interactor = CoreInteractor(container: container)
    let builder = CoreBuilder(interactor: interactor)
    let delegate = ConversationDelegate()
    
    return RouterView { router in
        builder.conversationView(router: router, delegate: delegate)
    }
}


