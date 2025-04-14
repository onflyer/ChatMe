//
//  AIChatModel.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 13. 4. 2025..
//

import Foundation
import GoogleGenerativeAI

struct AIChatModel: Codable {
    let role: AIChatRole
    let message: String
    
    init(role: AIChatRole, content: String) {
        self.role = role
        self.message = content
    }
    
    init(chat: GenerateContentResponse) {
        
    }
    
    func toModelContent() -> ModelContent {
        ModelContent(role: role.rawValue, parts: message)
    }
    
    enum CodingKeys: String, CodingKey {
        case role
        case message
    }
    
    var eventParameters: [String: Any] {
        let dict: [String: Any?] = [
            "aichat_\(CodingKeys.role.rawValue)": role.rawValue,
            "aichat_\(CodingKeys.message.rawValue)": message
        ]
        return dict.compactMapValues({ $0 })
    }
}

enum AIChatRole: String, Codable {
    case system, user
   
}
