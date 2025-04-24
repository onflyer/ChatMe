//
//  FirebaseConversationService.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 24. 4. 2025..
//

import Foundation
import FirebaseFirestore

struct FirebaseConversationService: ConversationService {
    
    var collection: CollectionReference {
        Firestore.firestore().collection("conversatons")
    }
    
    func createNewConversation(conversation: ConversationModel) async throws {
        try collection.document(conversation.id).setData(from: conversation, merge: true)
    }
    
    
}
