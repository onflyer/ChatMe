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
            if presenter.conversations.isEmpty {
                ContentUnavailableView("Nothing here at the moment", systemImage: "doc.fill.badge.plus", description: Text("Please start a conversation"))
                    .anyButton {
                        
                    }
                    .removeListRowFormatting()
            }
            ForEach(presenter.conversations) { conversation in
                ConversationRowView(
                    headline: conversation.title,
                    hasNewChat: false,
                    subheadline: presenter.lastMessageModel?.content?.message,
                    getLastMessage: {
                        await presenter.loadLastMessage(conversationId: conversation.id)
                    },
                    getTitle: {
                        presenter.listenForConversation(conversationId: conversation.id)
                    })
                .anyButton {
                    presenter.onConversationPressed(conversationId: conversation.id)
                }
            }
            .onDelete(perform: { index in
                presenter.onSwipeToDeleteAction(at: index)
            })
            .removeListRowFormatting()
        }
        .scrollContentBackground(.hidden)
        .background {
            GradientBackgroundView()
        }
        
        .animation(.default, value: presenter.conversations)
        .navigationTitle("Conversations")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                
                Menu(content: {
                    Text("Delete all")
                        .anyButton {
                            presenter.onConversationSettingsPressed()
                        }
                }, label: {
                    Image(systemName: "ellipsis")
                        .padding(8)
                })
            }
        }
        .task {
            await presenter.listenForConversations()
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


