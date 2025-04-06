//
//  FirebaseAuthService.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 6. 4. 2025..
//

import Foundation
import FirebaseAuth

struct FirebaseAuthService: AuthService {
    
    func getAuthenticatedUser() -> UserAuthInfo? {
        if let currentUser = Auth.auth().currentUser {
            return UserAuthInfo(user: currentUser)
        }

        return nil
    }
    
    
    
    func signIn(option: SignInOption) async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        switch option {
        case .apple:
            return try await authenticateUser_Anonymous()
//            return try await authenticateUser_Apple()
        case .google(GIDClientID: let GIDClientID):
            return try await authenticateUser_Anonymous()
//            return try await authenticateUser_Google(GIDClientID: GIDClientID)
        case .anonymous:
            return try await authenticateUser_Anonymous()
        }
    }
    
    func authenticateUser_Anonymous() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        // Sign in to Firebase
        let authDataResult = try await Auth.auth().signInAnonymously()
        
        // Convert Firebase AuthDataResult to local UserAuthInfo
        return authDataResult.asAuthInfo()
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }

    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.userNotFound
        }

        try await user.delete()
    }
}

extension FirebaseAuthService {
    private enum AuthError: LocalizedError {
        case noResponse
        case userNotFound

        var errorDescription: String? {
            switch self {
            case .noResponse:
                return "Bad response."
            case .userNotFound:
                return "Current user not found."
            }
        }
    }
}

extension AuthDataResult {

    // Decouple firebase type AuthDataResult to local type UserAuthInfo
    func asAuthInfo(firstName: String? = nil, lastName: String? = nil) -> (user: UserAuthInfo, isNewUser: Bool) {
        let user = UserAuthInfo(user: user, firstName: firstName, lastName: lastName)
        let isNewUser = additionalUserInfo?.isNewUser ?? true
        return (user, isNewUser)
    }
}
