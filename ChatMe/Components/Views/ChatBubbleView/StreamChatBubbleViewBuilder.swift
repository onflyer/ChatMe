//
//  StreamChatBubbleViewBuilder.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 30. 5. 2025..
//

import SwiftUI

struct StreamChatBubbleViewBuilder: View {
    
    var message: ConversationMessageModel = .mock
    var isCurrentUser: Bool = false
    var currentUserProfileColor: Color = .blue
    var imageName: String?

    var body: some View {
        ZStack {
            StreamChatBubbleView(
                text: message.content?.message ?? "",
                textColor: isCurrentUser ? .white : .primary,
                backgroundColor: isCurrentUser ? currentUserProfileColor : Color(uiColor: .systemGray6),
                showImage: !isCurrentUser,
                imageName: imageName
            )
            .frame(maxWidth: .infinity, alignment: isCurrentUser ? .trailing : .leading)
            .padding(.leading, isCurrentUser ? 50 : 0)
            .padding(.trailing, isCurrentUser ? 0 : 50)
        }
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 24) {
            StreamChatBubbleViewBuilder()
            StreamChatBubbleViewBuilder(isCurrentUser: true)
            StreamChatBubbleViewBuilder(
                message: ConversationMessageModel(
                    id: UUID().uuidString,
                    chatId: UUID().uuidString,
//                    authorId: UUID().uuidString,
                    content: AIChatModel(role: .user, content: "This is some longer content that goes on to multiple lines and keeps on going to another line!"),
                    seenByIds: nil,
                    dateCreated: .now
                )
            )
            StreamChatBubbleViewBuilder(
                message: ConversationMessageModel(
                    id: UUID().uuidString,
                    chatId: UUID().uuidString,
//                    authorId: UUID().uuidString,
                    content: AIChatModel(role: .user, content: "This is some longer content that goes on to multiple lines and keeps on going to another line!"),
                    seenByIds: nil,
                    dateCreated: .now
                ),
                isCurrentUser: true,
                currentUserProfileColor: .blue
            )
        }
        .padding(12)
    }
}
