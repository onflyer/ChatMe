//
//  AppViewInteractor.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 30. 3. 2025..
//

import Foundation

@MainActor
protocol AppViewInteractor {
    var showTabBar: Bool { get }
    func trackEvent(event: LoggableEvent)
    func trackScreenEvent(event: LoggableEvent)
 
}

extension CoreInteractor: AppViewInteractor { }
