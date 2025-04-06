//
//  CoreInteractor.swift
//
//  Created by Aleksandar Milidrag on 21. 12. 2024..
//

import Foundation

@MainActor
struct CoreInteractor {
    
    private let authManager: AuthManager
    private let logManager: LogManager
    private let appState: AppState
    
    init(container: DependencyContainer) {
        self.authManager = container.resolve(AuthManager.self)!
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
