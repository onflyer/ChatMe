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
                ConversationRowView(
                    headline: conversation.title,
                    hasNewChat: false,
                    subheadline: presenter.lastMessageModel?.content?.message,
                    getLastMessage: {
                        await presenter.loadLastMessage(
                            conversationId: conversation.id
                        )
                    },
                    getTitle: {
                        
                })
                .anyButton {
                    presenter.onConversationPressed(conversationId: conversation.id)
                }
                .onFirstAppear {
                    Task {
                        await presenter.updateConversationsTitleSummary(conversationId: conversation.id) 
                    }
                }
            }
            .onDelete(perform: { index in
                presenter.onSwipeToDeleteAction(at: index)
            })
            .removeListRowFormatting()
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


