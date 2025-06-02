//
//  ConversationModel.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 24. 4. 2025..
//

import Foundation

struct ConversationModel: Identifiable, Codable, Hashable, StringIdentifiable {
    let id: String
    let userId: String
    let title: String
    let dateCreated: Date
    let dateModified: Date
        
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case title
        case dateCreated = "date_created"
        case dateModified = "date_modified"
    }
    
    var eventParameters: [String: Any] {
        let dict: [String: Any?] = [
            "chat_\(CodingKeys.id.rawValue)": id,
            "chat_\(CodingKeys.userId.rawValue)": userId,
            "chat_\(CodingKeys.dateCreated.rawValue)": dateCreated,
            "chat_\(CodingKeys.dateModified.rawValue)": dateModified
        ]
        return dict.compactMapValues({ $0 })
    }
    
    static func new(userId: String) -> Self {
        ConversationModel(
            id:  UUID().uuidString,
            userId: userId,
            title: "New Conversation",
            dateCreated: .now,
            dateModified: .now
        )
    }
    
    var dateCreatedCalculated: Date {
        dateCreated 
    }
    
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        let now = Date()
        return [
            ConversationModel(
                id: "mock_chat_1",
                userId: UserAuthInfo.mock().uid,
                title: "Title 1",
                dateCreated: now,
                dateModified: now
            ),
            ConversationModel(
                id: "mock_chat_2",
                userId: UserAuthInfo.mock().uid,
                title: "Title 2",
                dateCreated: now.addingTimeInterval(
                    hours: -1
                ),
                dateModified: now.addingTimeInterval(
                    minutes: -30
                )
            ),
            ConversationModel(
                id: "mock_chat_3",
                userId: UserAuthInfo.mock().uid,
                title: "Title 3",
                dateCreated: now.addingTimeInterval(
                    hours: -2
                ),
                dateModified: now.addingTimeInterval(
                    hours: -1
                )
            ),
            ConversationModel(
                id: "mock_chat_4",
                userId: UserAuthInfo.mock().uid,
                title: "Title 4",
                dateCreated: now.addingTimeInterval(
                    days: -1
                ),
                dateModified: now.addingTimeInterval(
                    hours: -10
                )
            )
        ]
    }
}
