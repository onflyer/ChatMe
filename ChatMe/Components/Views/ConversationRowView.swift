//
//  ConversationRowView.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 24. 4. 2025..
//

import SwiftUI

struct ConversationRowView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
//    var imageName: String? = Constants.randomImage
    var headline: String? = "Alpha"
    var subheadline: String? = "This is the last message in the chat."
    var hasNewChat: Bool = true
    
    var body: some View {
        HStack(spacing: 8) {
//            ZStack {
//                if let imageName {
//                    ImageLoaderView(urlString: imageName)
//                } else {
//                    Rectangle()
//                        .fill(.secondary.opacity(0.5))
//                }
//            }
//            .frame(width: 50, height: 50)
//            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                if let headline {
                    Text(headline)
                        .font(.headline)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                }
                if let subheadline {
                    Text(subheadline)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .minimumScaleFactor(1)
                }
            }
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if hasNewChat {
                Text("...")
                    .badgeButton()
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                    .frame(maxWidth: 50)
            }
        }
        .frame(minHeight: 50)
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(colorScheme.backgroundPrimary)
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        
        List {
            ConversationRowView()
                .removeListRowFormatting()
            ConversationRowView(hasNewChat: false)
                .removeListRowFormatting()
            ConversationRowView()
                .removeListRowFormatting()
            ConversationRowView(headline: nil, hasNewChat: false)
                .removeListRowFormatting()
            ConversationRowView(subheadline: nil, hasNewChat: false)
                .removeListRowFormatting()
        }
    }
}
