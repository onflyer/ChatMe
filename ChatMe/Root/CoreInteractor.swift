//
//  CoreInteractor.swift
//
//  Created by Aleksandar Milidrag on 21. 12. 2024..
//

import Foundation

@MainActor
struct CoreInteractor {
    
    let logManager: LogManager
    let appState: AppState
    
    init(container: DependencyContainer) {
        self.logManager = container.resolve(LogManager.self)!
        self.appState = container.resolve(AppState.self)!
    }
    
    // MARK: AppState
    
    var showTabBar: Bool {
        appState.showTabBar
    }
    
    func updateAppState(showTabBarView: Bool) {
        appState.updateViewState(showTabBarView: showTabBarView)
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
