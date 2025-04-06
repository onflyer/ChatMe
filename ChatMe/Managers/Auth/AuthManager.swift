//
//  AuthManager.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 6. 4. 2025..
//

import SwiftUI

@MainActor
@Observable
class AuthManager {
    let service: AuthService
    
    private(set) var auth: UserAuthInfo?
    
    init(service: AuthService) {
        self.service = service
        self.auth = service.getAuthenticatedUser()
    }
    
    private func setCurrentAuth(auth value: UserAuthInfo?) {
        self.auth = value
    }
    
    @discardableResult
    public func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let result = try await signIn(option: .anonymous)
        setCurrentAuth(auth: result.user)
        return result
    }
    
    private func signIn(option: SignInOption) async throws -> (user: UserAuthInfo, isNewUser: Bool) {
//        self.logger?.trackEvent(event: Event.signInStart(option: option))
        
//        defer {
//            // After user's auth changes, re-attach auth listener.
//            // This isn't usually necessary, but if the user is "linking" to an anonymous account,
//            // The Firebase auth listener does not auto-publish new value (since it's the same UID).
//            // Re-adding a new listener should catch any catch edge cases.
//            addAuthListener()
//        }

        do {
            let result = try await service.signIn(option: option)
            setCurrentAuth(auth: result.user)
//            logger?.trackEvent(event: Event.signInSuccess(option: option, user: result.user, isNewUser: result.isNewUser))
            return result
        } catch {
//            logger?.trackEvent(event: Event.signInFail(error: error))
            throw error
        }
    }
    
}
