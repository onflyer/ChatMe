//
//  AppViewInteractor.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 30. 3. 2025..
//

import Foundation

@MainActor
protocol AppViewInteractor {
    var auth: UserAuthInfo? { get }
    var showTabBar: Bool { get }
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool)
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool)
    func trackEvent(event: LoggableEvent)
    func trackScreenEvent(event: LoggableEvent)
 
}

extension CoreInteractor: AppViewInteractor { }
