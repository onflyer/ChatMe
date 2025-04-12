//
//  MockAuthService.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 6. 4. 2025..
//
import SwiftUI

@MainActor
class MockAuthService: AuthService {
    @Published private(set) var currentUser: UserAuthInfo?

    init(user: UserAuthInfo? = nil) {
        self.currentUser = user
    }

    public func getAuthenticatedUser() -> UserAuthInfo? {
        currentUser
    }

    public func addAuthenticatedUserListener() -> AsyncStream<UserAuthInfo?> {
        AsyncStream { continuation in
            Task {
                for await value in $currentUser.values {
                    continuation.yield(value)
                }
            }
        }
    }
    
    public func removeAuthenticatedUserListener() {
        
    }

    public func signOut() throws {
        currentUser = nil
    }

    public func signIn(option: SignInOption) async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        switch option {
        case .apple, .google, .anonymous:
            let user = UserAuthInfo.mock(isAnonymous: false)
            currentUser = user
            return (user, false)
        }
    }

    public func deleteAccount() async throws {
        currentUser = nil
    }

}
