//
//  FirebaseAuthService.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 6. 4. 2025..
//

import Foundation
import FirebaseAuth

struct FirebaseAuthService {
    
    func getAuthenticatedUser() -> UserAuthInfo? {
        if let user = Auth.auth().currentUser {
            return UserAuthInfo(user: user)
        } else {
            return nil
        }
    }
    
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
       let result = try await Auth.auth().signInAnonymously()
        let user = UserAuthInfo(user: result.user)
        let isNewUser = result.additionalUserInfo?.isNewUser ?? true
        return (user, isNewUser)
    }
}


