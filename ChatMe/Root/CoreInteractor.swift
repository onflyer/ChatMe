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
    private let aiManager: AIManager
    private let conversationManager: ConversationManager
    private let logManager: LogManager
    private let appState: AppState
    
    init(container: DependencyContainer) {
        self.authManager = container.resolve(AuthManager.self)!
        self.userManager = container.resolve(UserManager.self)!
        self.aiManager = container.resolve(AIManager.self)!
        self.conversationManager = container.resolve(ConversationManager.self)!
        self.logManager = container.resolve(LogManager.self)!
        self.appState = container.resolve(AppState.self)!
    }
    
    // MARK: AIManager
    
    func generateText(chats: [AIChatModel]) async throws -> AIChatModel {
        try await aiManager.generateText(chats: chats)
    }
    
    // MARK: ConversationManager
    
    func createNewConversation(conversation: ConversationModel) async throws {
        try await conversationManager.createNewConversation(conversation: conversation)
    }
    
    func addConversationMessage(conversationId: String, message: ConversationMessageModel) async throws {
        try await conversationManager.addConversationMessage(conversationId: conversationId, message: message)
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
    
    func getAuthId() throws -> String {
        try authManager.getAuthId()
    }
    
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        try await authManager.signInAnonymously()
    }
    
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        try await authManager.signInApple()
    }
    
    func signInGoogle() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        guard let clientId = FirebaseAuthService.clientId else {
            throw AppError("Firebase not configured or clientID missing")
        }
        return try await authManager.signInGoogle(GIDClientID: clientId)
    }
    
    func logIn(user: UserAuthInfo, isNewUser: Bool) async throws {
        try await userManager.logIn(auth: user, isNewUser: isNewUser)
//        try await purchaseManager.logIn(
//            userId: user.uid,
//            userAttributes: PurchaseProfileAttributes(
//                email: user.email,
//                mixpanelDistinctId: Constants.mixpanelDistinctId,
//                firebaseAppInstanceId: Constants.firebaseAnalyticsAppInstanceID
//            )
//        )
        logManager.addUserProperties(dict: Utilities.eventParameters, isHighPriority: false)
    }
    
    func signOut() async throws {
        try authManager.signOut()
//        try await purchaseManager.logOut()
        userManager.signOut()
    }
    
    func deleteAccount() async throws {
        _ = try authManager.getAuthId()
        try await userManager.deleteCurrentUser()
        try await authManager.deleteAccount()
//        try await purchaseManager.logOut()
        logManager.deleteUserProfile()
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
