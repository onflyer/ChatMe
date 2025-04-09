//
//  CoreInteractor.swift
//
//  Created by Aleksandar Milidrag on 21. 12. 2024..
//

import SwiftUI

@MainActor
struct CoreInteractor {
    
    private let authManager: AuthManager
    private let userManager: UserManager
    private let logManager: LogManager
    private let appState: AppState
    
    init(container: DependencyContainer) {
        self.authManager = container.resolve(AuthManager.self)!
        self.userManager = container.resolve(UserManager.self)!
        self.logManager = container.resolve(LogManager.self)!
        self.appState = container.resolve(AppState.self)!
    }
    
    // MARK: AppState
    
    func updateAppState(showTabBarView: Bool) {
        appState.updateViewState(showTabBarView: showTabBarView)
    }
    
    var showTabBar: Bool {
        appState.showTabBar
    }
    
    // MARK: AuthManager
    
    var auth: UserAuthInfo? {
        authManager.auth
    }
    
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        try await authManager.signInAnonymously()
    }
    
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        try await authManager.signInApple()
    }
    
    func signOut() async throws {
        try authManager.signOut()
//        try await purchaseManager.logOut()
//        userManager.signOut()
    }
    
    func deleteAccount() async throws {
        _ = try authManager.getAuthId()
//        try await userManager.deleteCurrentUser()
        try await authManager.deleteAccount()
//        try await purchaseManager.logOut()
//        logManager.deleteUserProfile()
    }
    
    //MARK: User Manager
    
    var currentUser: UserModel? {
        userManager.currentUser
    }
    
    func getUser(userId: String) async throws -> UserModel {
        try await userManager.getUser(userId: userId)
    }
    
    func saveOnboardingComplete() async throws {
        try await userManager.saveOnboardingCompleteForCurrentUser()
    }
    
    func saveUserName(name: String) async throws {
        try await userManager.saveUserName(name: name)
    }
    
    func saveUserEmail(email: String) async throws {
        try await userManager.saveUserEmail(email: email)
    }
    
    func saveUserProfileImage(image: UIImage) async throws {
        try await userManager.saveUserProfileImage(image: image)
    }
    
    func saveUserFCMToken(token: String) async throws {
        try await userManager.saveUserFCMToken(token: token)
    }
}


extension CoreInteractor {
    
    func trackEvent(eventName: String, parameters: [String: Any]? = nil, type: LogType = .analytic) {
        logManager.trackEvent(eventName: eventName, parameters: parameters, type: type)
    }
    
    func trackEvent(event: AnyLoggableEvent) {
        logManager.trackEvent(event: event)
    }
    
    func trackEvent(event: LoggableEvent) {
        logManager.trackEvent(event: event)
    }
    
    func trackScreenEvent(event: LoggableEvent) {
        logManager.trackEvent(event: event)
    }
    
}
