//
//  Dependencies.swift
//  TMDB_VIPER
//
//  Created by Aleksandar Milidrag on 21. 12. 2024.
//

import SwiftUI
import SwiftfulLogging

typealias LogManager = SwiftfulLogging.LogManager
typealias LoggableEvent = SwiftfulLogging.LoggableEvent
typealias LogType = SwiftfulLogging.LogType
typealias LogService = SwiftfulLogging.LogService
typealias AnyLoggableEvent = SwiftfulLogging.AnyLoggableEvent


@MainActor
struct Dependencies {
    let container: DependencyContainer
    let authManager: AuthManager
    let userManager: UserManager
    let logManager: LogManager
    let appState: AppState
    
    init() {
        logManager = LogManager(services: [ConsoleService(printParameters: true)])
        authManager = AuthManager(service: FirebaseAuthService(), logger: logManager)
        userManager = UserManager(services: ProductionUserServices(), logManager: logManager)
        appState = AppState()
        
        
        let container = DependencyContainer()
        container.register(AuthManager.self, service: authManager)
        container.register(UserManager.self, service: userManager)
        container.register(LogManager.self, service: logManager)
        container.register(AppState.self, service: appState)
        
        self.container = container
    }
}

@MainActor
class DevPreview {
    static let shared = DevPreview()
    
    func container() -> DependencyContainer {
        let container = DependencyContainer()
        container.register(AuthManager.self, service: authManager)
        container.register(UserManager.self, service: userManager)
        container.register(LogManager.self, service: logManager)
        container.register(AppState.self, service: appState)
        
        return container
    }
    
    let authManager: AuthManager
    let userManager: UserManager
    let logManager: LogManager
    let appState: AppState
    
    init(isSignedIn: Bool = true) {
        self.authManager = AuthManager(service: MockAuthService(user: isSignedIn ? .mock() : nil))
        self.userManager = UserManager(services: MockUserServices(user: isSignedIn ? .mock : nil))
        self.logManager = LogManager(services: [])
        self.appState = AppState()
    }
    
    
}

