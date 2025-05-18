//
//  FirebaseConversationService.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 24. 4. 2025..
//

import Foundation
import FirebaseFirestore

struct FirebaseConversationService: ConversationService {
    
    private var conversationsCollection: CollectionReference {
        Firestore.firestore().collection("conversatons")
    }
    //subcollection of conversations
    private func messagesSubcollection(conversationId: String) -> CollectionReference {
        conversationsCollection.document(conversationId).collection("messages")
    }
    
    func createNewConversation(conversation: ConversationModel) async throws {
        try conversationsCollection.document(conversation.id).setData(from: conversation, merge: true)
    }
    
    func addConversationMessage(conversationId: String, message: ConversationMessageModel) async throws {
        // Add the message to conversation sub-collection
        try messagesSubcollection(conversationId: conversationId).document(message.id).setData(from: message, merge: true)
        
        try await conversationsCollection.document(conversationId).updateData([
            ConversationModel.CodingKeys.dateModified.rawValue: Date.now
        ])
    }
    
    func listenForNewMessages(conversationId: String) -> AsyncThrowingStream<[ConversationMessageModel], Error> {
        messagesSubcollection(conversationId: conversationId).streamAllDocuments()
    }
    
    func getConversation(userId: String) async throws -> ConversationModel? {
        let result: [ConversationModel] = try await conversationsCollection.whereField(ConversationModel.CodingKeys.userId.rawValue, isEqualTo: userId)
            .order(by: ConversationModel.CodingKeys.dateModified.rawValue, descending: true).getDocuments(as: [ConversationModel].self)
        return result.first
    }
    
    func getAllConversationsForUser(userId: String) async throws -> [ConversationModel] {
        try await conversationsCollection.whereField(ConversationModel.CodingKeys.userId.rawValue, isEqualTo: userId)
            .getAllDocuments()
    }
    
    func getLastConversationMessage(conversationId: String) async throws -> ConversationMessageModel? {
        let messages: [ConversationMessageModel] = try await messagesSubcollection(conversationId: conversationId)
            .order(by: ConversationMessageModel.CodingKeys.dateCreated.rawValue, descending: true)
            .limit(to: 1)
            .getAllDocuments()
            
        return messages.first
    }
    
}
