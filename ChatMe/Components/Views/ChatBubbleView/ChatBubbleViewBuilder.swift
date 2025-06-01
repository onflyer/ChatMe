//
//  ChatBubbleViewBuilder.swift
//  AIChatCourse
//
//  Created by Nick Sarno on 10/10/24.
//

import SwiftUI

struct ChatBubbleViewBuilder: View {
    
    var message: ConversationMessageModel = .mock
    var isCurrentUser: Bool = false
    var currentUserProfileColor: Color = .blue
    var imageName: String?
    var onImagePressed: (() -> Void)?

    var body: some View {
        ZStack {
            ChatBubbleView(
                text: message.content?.message ?? "",
                textColor: isCurrentUser ? .white : .primary,
                backgroundColor: isCurrentUser ? currentUserProfileColor : Color(uiColor: .systemGray6),
                showImage: !isCurrentUser,
                imageName: imageName,
                onImagePressed: onImagePressed
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
            ChatBubbleViewBuilder()
            ChatBubbleViewBuilder(isCurrentUser: true)
            ChatBubbleViewBuilder(
                message: ConversationMessageModel(
                    id: UUID().uuidString,
                    chatId: UUID().uuidString,
//                    authorId: UUID().uuidString,
                    content: AIChatModel(role: .user, content: "This is some longer content that goes on to multiple lines and keeps on going to another line!"),
                    seenByIds: nil,
                    dateCreated: .now
                )
            )
            ChatBubbleViewBuilder(
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
