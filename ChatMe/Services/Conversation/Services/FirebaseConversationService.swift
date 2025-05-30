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
    
    private var conversationReportsCollection: CollectionReference {
        Firestore.firestore().collection("conversation_reports")
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
    
    func updateMessageForStream(conversationId: String, messageId: String, message: AIChatModel) async throws {
//        let data = try Firestore.Encoder().encode(message)
        try await messagesSubcollection(conversationId: conversationId).document(messageId).updateData([
            
            ConversationMessageModel.CodingKeys.content.rawValue: message.asJsonDictionary()
        ])
    }
    
    func streamConversationMessages(conversationId: String) -> AsyncThrowingStream<[ConversationMessageModel], Error> {
        messagesSubcollection(conversationId: conversationId).streamAllDocuments()
    }
    
    //make a stream for collection filtered for userId
    func streamConversations(userId: String) async throws -> AsyncThrowingStream<[ConversationModel], Error> {
       let query = conversationsCollection.whereField(ConversationModel.CodingKeys.userId.rawValue, isEqualTo: userId)
       return query.addSnapshotStream(as: [ConversationModel].self)
    
    }
    
    func getMostRecentConversation(userId: String) async throws -> ConversationModel? {
        let result: [ConversationModel] = try await conversationsCollection.whereField(ConversationModel.CodingKeys.userId.rawValue, isEqualTo: userId)
            .order(by: ConversationModel.CodingKeys.dateModified.rawValue, descending: true).getDocuments(as: [ConversationModel].self)
        return result.first
    }
    
    func getConversation(conversatonId: String) async throws -> ConversationModel? {
        try await conversationsCollection.getDocument(id: conversatonId)
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
    
    func getConversationMessagesForSummary(conversationId: String) async throws -> [ConversationMessageModel] {
        return try await messagesSubcollection(conversationId: conversationId).getAllDocuments()
    }
    
    func deleteConversation(conversationId: String) async throws {
        //deleting document DOES NOT delete subcollection...
        async let deleteConversation: () =  conversationsCollection.deleteDocument(id: conversationId)
        // so we need to delete subcollection
        async let deleteConversationMessages: () =  messagesSubcollection(conversationId: conversationId).deleteAllDocuments()
        
        let (_, _) = await (try deleteConversation, try deleteConversationMessages )

    }
    
    func deleteAllConversationsForUser(userId: String) async throws {
        let conversations = try await getAllConversationsForUser(userId: userId)
        
        try await withThrowingTaskGroup(of: Void.self) { group in
            for item in conversations {
                group.addTask {
                    try await deleteConversation(conversationId: item.id)
                }
            }
            
            try await group.waitForAll()
        }
    }
    
    func reportChat(report: ConversationReportModel) async throws {
        try await conversationReportsCollection.setDocument(document: report)
    }
}
