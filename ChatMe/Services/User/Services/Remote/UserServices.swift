//
//  RemoteUserService.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 9. 4. 2025..
//

@MainActor
protocol UserServices {
    var remote: RemoteUserService { get }
    var local: LocalUserPersistence { get }
}

struct ProductionUserServices: UserServices {
    let remote: RemoteUserService = FirebaseUserService()
    let local: LocalUserPersistence = FileManagerUserPersistence()
}
