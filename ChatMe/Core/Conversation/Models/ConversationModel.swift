//
//  ConversationModel.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 24. 4. 2025..
//

import Foundation

struct ChatModel: Identifiable, Codable, Hashable, StringIdentifiable {
    let id: String
    let userId: String
//    let avatarId: String
    let dateCreated: Date
    let dateModified: Date
        
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
//        case avatarId = "avatar_id"
        case dateCreated = "date_created"
        case dateModified = "date_modified"
    }
    
    var eventParameters: [String: Any] {
        let dict: [String: Any?] = [
            "chat_\(CodingKeys.id.rawValue)": id,
            "chat_\(CodingKeys.userId.rawValue)": userId,
//            "chat_\(CodingKeys.avatarId.rawValue)": avatarId,
            "chat_\(CodingKeys.dateCreated.rawValue)": dateCreated,
            "chat_\(CodingKeys.dateModified.rawValue)": dateModified
        ]
        return dict.compactMapValues({ $0 })
    }
    
    static func chatId(userId: String, id: String) -> String {
        "\(userId)_\(id)"
    }
    
    static func new(userId: String, id: String) -> Self {
        ChatModel(
            id: chatId(userId: userId, id: id),
            userId: userId,
//            avatarId: avatarId,
            dateCreated: .now,
            dateModified: .now
        )
    }
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        let now = Date()
        return [
            ChatModel(
                id: "mock_chat_1",
                userId: UserAuthInfo.mock().uid,
//                avatarId: AvatarModel.mocks.randomElement()!.avatarId,
                dateCreated: now,
                dateModified: now
            ),
            ChatModel(
                id: "mock_chat_2",
                userId: UserAuthInfo.mock().uid,
//                avatarId: AvatarModel.mocks.randomElement()!.avatarId,
                dateCreated: now.addingTimeInterval(
                    hours: -1
                ),
                dateModified: now.addingTimeInterval(
                    minutes: -30
                )
            ),
            ChatModel(
                id: "mock_chat_3",
                userId: UserAuthInfo.mock().uid,
//                avatarId: AvatarModel.mocks.randomElement()!.avatarId,
                dateCreated: now.addingTimeInterval(
                    hours: -2
                ),
                dateModified: now.addingTimeInterval(
                    hours: -1
                )
            ),
            ChatModel(
                id: "mock_chat_4",
                userId: UserAuthInfo.mock().uid,
//                avatarId: AvatarModel.mocks.randomElement()!.avatarId,
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
