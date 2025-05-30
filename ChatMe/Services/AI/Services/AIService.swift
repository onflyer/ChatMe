//
//  AIService.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 12. 4. 2025..
//

import Foundation

protocol AIService {
    func generateText(chats: [AIChatModel]) async throws -> AIChatModel
    func generateTextStream(chats: [AIChatModel]) async throws -> AsyncThrowingStream<AIChatModel, Error>
}
