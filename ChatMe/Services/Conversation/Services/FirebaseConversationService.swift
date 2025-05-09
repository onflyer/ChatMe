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
    
    
    
}
