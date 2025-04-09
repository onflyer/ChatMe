//
//  LocalUserPersistence.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 9. 4. 2025..
//


@MainActor
protocol LocalUserPersistence {
    func getCurrentUser() -> UserModel?
    func saveCurrentUser(user: UserModel?) throws
}