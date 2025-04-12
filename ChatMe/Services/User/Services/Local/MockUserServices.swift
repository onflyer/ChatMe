//
//  MockUserServices.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 9. 4. 2025..
//


@MainActor
struct MockUserServices: UserServices {
    let remote: RemoteUserService
    let local: LocalUserPersistence

    init(user: UserModel? = nil) {
        self.remote = MockUserService(user: user)
        self.local = MockUserPersistence(user: user)
    }
}
