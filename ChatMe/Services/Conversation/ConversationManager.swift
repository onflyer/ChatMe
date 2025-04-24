//
//  ConversationManager.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 24. 4. 2025..
//

import Foundation

@MainActor
@Observable
class ConversationManager {
    
    let service: ConversationService
    
    init(service: ConversationService) {
        self.service = service
    }
}
