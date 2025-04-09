//
//  MockUserPersistence.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 9. 4. 2025..
//
import Foundation

struct MockUserPersistence: LocalUserPersistence {
    
    let currentUser: UserModel?
    
    init(user: UserModel? = nil) {
        self.currentUser = user
    }
    
    func getCurrentUser() -> UserModel? {
        currentUser
    }
    
    func saveCurrentUser(user: UserModel?) throws {
        
    }
}
