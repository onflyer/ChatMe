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

    
    
    init() {
        logManager = LogManager(services: [ConsoleService(printParameters: true)])
        let container = DependencyContainer()
        container.register(LogManager.self, service: logManager)

        self.container = container
    }
}

@MainActor
class DevPreview {
    static let shared = DevPreview()
    let logManager: LogManager

    
    init() {
        self.logManager = LogManager(services: [])

    }
    
    func container() -> DependencyContainer {
        let container = DependencyContainer()
        container.register(LogManager.self, service: logManager)

        
        return container
    }
}

