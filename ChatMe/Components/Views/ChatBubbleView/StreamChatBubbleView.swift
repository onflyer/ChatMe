//
//  StreamChatBubbleView.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 30. 5. 2025..
//

import SwiftUI

struct StreamChatBubbleView: View {
    
    var text: String = "This is sample text."
    var textColor: Color = .primary
    var backgroundColor: Color = Color(uiColor: .systemGray6)
    var showImage: Bool = true
    var imageName: String?
    var handleTextStream: (() async -> Void)?
    
    let offset: CGFloat = 14
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(text)
                .font(.body)
                .foregroundStyle(textColor)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(backgroundColor)
                .cornerRadius(6)
        }
        .padding(.bottom, showImage ? offset : 0)
        .animation(.default, value: text)

    }
}

#Preview {
    ScrollView {
        VStack(spacing: 16) {
            StreamChatBubbleView()
            StreamChatBubbleView(text: "This is a chat bubble with a lot of text that wraps to multiple lines and it keeps on going. This is a chat bubble with a lot of text that wraps to multiple lines and it keeps on going.")

            StreamChatBubbleView(
                textColor: .white,
                backgroundColor: .blue,
                showImage: false,
                imageName: nil
            )
            
            StreamChatBubbleView(
                text: "This is a chat bubble with a lot of text that wraps to multiple lines and it keeps on going. This is a chat bubble with a lot of text that wraps to multiple lines and it keeps on going.",
                textColor: .white,
                backgroundColor: .blue,
                showImage: false,
                imageName: nil
            )
        }
        .padding(8)
    }
}
