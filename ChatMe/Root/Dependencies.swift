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
    let logManager: LogManager
    let appState: AppState
    
    init() {
        logManager = LogManager(services: [ConsoleService(printParameters: true)])
        appState = AppState()
        
        
        let container = DependencyContainer()
        container.register(LogManager.self, service: logManager)
        container.register(AppState.self, service: appState)

        self.container = container
    }
}

@MainActor
class DevPreview {
    static let shared = DevPreview()
    let logManager: LogManager
    let appState: AppState

    
    init(isSignedIn: Bool = true) {
        self.logManager = LogManager(services: [])
        self.appState = AppState()
    }
    
    func container() -> DependencyContainer {
        let container = DependencyContainer()
        container.register(LogManager.self, service: logManager)
        container.register(AppState.self, service: appState)
        
        return container
    }
}

