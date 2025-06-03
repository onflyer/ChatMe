//
//  StreamChatView.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 30. 5. 2025..
//

import SwiftUI

struct StreamChatDelegate {
    var eventParameters: [String: Any]? {
        nil
    }
    
    var conversationId: String = ConversationModel.mock.id
}

struct StreamChatView: View {
    
    @State var presenter: ChatStreamPresenter
    let delegate: StreamChatDelegate
    
    var body: some View {
        VStack(spacing: 0) {
            scrollViewSection
            textFieldSection
        }
        .navigationTitle("Chat")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Image(systemName: "square.and.pencil")
                        .anyButton {
                            presenter.onPencilPressed()
                        }
                    Image(systemName: "ellipsis")
                        .padding(8)
                        .anyButton {
                            presenter.onSettingsPressed()
                        }
                }
                
            }
        }
        .task {
            await presenter.loadConversation(conversationId: delegate.conversationId)
            await presenter.listenForConversationMessages()
        }
        .onAppear {
            presenter.onViewAppear(delegate: delegate)
        }
        .onDisappear {
            presenter.onViewDisappear(delegate: delegate)
            presenter.updateConversationsTitleSummary(conversationId: presenter.conversation?.id ?? "no id")
        }
    }
    
    private var scrollViewSection: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(presenter.chatMessages) { message in
                    if presenter.messageIsDelayedTimestamp(message: message) {
                        timestampView(date: message.dateCreatedCalculated)
                    }
                    let isCurrentUser = presenter.messageIsCurrentUser(message: message)
                        StreamChatBubbleViewBuilder(
                            message: message,
                            isCurrentUser: isCurrentUser,
                            imageName: nil
                        )
                    .id(message.id)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(8)
            .rotationEffect(.degrees(180))
        }
        .rotationEffect(.degrees(180))
        .scrollPosition(id: $presenter.scrollPosition, anchor: .center)
        .animation(.default, value: presenter.chatMessages.count)
        .animation(.default, value: presenter.scrollPosition)
    }
    
    private var textFieldSection: some View {
        TextField("Ask anything...", text: $presenter.textFieldText)
            .keyboardType(.alphabet)
            .autocorrectionDisabled()
            .padding(12)
            .padding(.trailing, 60)
            .overlay(
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 15))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .foregroundStyle(.white)
                    .background(.accent)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding(.horizontal, 5)
                    .anyButton(.plain, action: {
                        presenter.onSendMessagePressed()
                    })
                
                , alignment: .trailing
            )
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(Color(uiColor: .systemBackground))
                    
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                }
            )
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color(uiColor: .secondarySystemBackground))
    }
    
    private func timestampView(date: Date) -> some View {
        Group {
            Text(date.formatted(date: .abbreviated, time: .omitted))
            +
            Text(" • ")
            +
            Text(date.formatted(date: .omitted, time: .shortened))
        }
        .foregroundStyle(.secondary)
        .font(.callout)
        .lineLimit(1)
        .minimumScaleFactor(0.3)
    }
}

#Preview {
    let container = DevPreview.shared.container()
    let interactor = CoreInteractor(container: container)
    let builder = CoreBuilder(interactor: interactor)
    let delegate = StreamChatDelegate()
    
    return RouterView { router in
        builder.streamChatView(router: router, delegate: delegate)
    }
}
