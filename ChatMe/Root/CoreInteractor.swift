//
//  CoreInteractor.swift
//  TMDB_VIPER
//
//  Created by Aleksandar Milidrag on 21. 12. 2024..
//

import Foundation
import MapKit

@MainActor
struct CoreInteractor {
    
    let logManager: LogManager

    
    init(container: DependencyContainer) {
        self.logManager = container.resolve(LogManager.self)!
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
    
    func trackScreenView(event: LoggableEvent) {
        logManager.trackEvent(event: event)
    }
    
}
