//
//  AuthService.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 6. 4. 2025..
//

import Foundation

@MainActor
protocol AuthService: Sendable {
    func getAuthenticatedUser() -> UserAuthInfo?
    func signIn(option: SignInOption) async throws -> (user: UserAuthInfo, isNewUser: Bool)
    func signOut() throws
    func deleteAccount() async throws
}
