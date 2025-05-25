//
//  ChatReportModel.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 24. 5. 2025..
//
import Foundation

struct ConversationReportModel: Codable, StringIdentifiable {
    let id: String
    let conversationId: String
    let userId: String // reporting user
    let isActive: Bool
    let dateCreated: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case conversationId = "conversation_id"
        case userId = "user_id"
        case isActive = "is_active"
        case dateCreated = "date_created"
    }
    
    static func new(conversationId: String, userId: String) -> Self {
        ConversationReportModel(
            id: UUID().uuidString,
            conversationId: conversationId,
            userId: userId,
            isActive: true,
            dateCreated: .now
        )
    }
}
