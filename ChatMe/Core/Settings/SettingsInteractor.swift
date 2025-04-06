//
//  SettingsInteractor.swift
//  
//
//  
//

@MainActor
protocol SettingsInteractor {
    var auth: UserAuthInfo? { get }
    func updateAppState(showTabBarView: Bool)
    func trackEvent(event: LoggableEvent)
    func trackScreenEvent(event: LoggableEvent)
}

extension CoreInteractor: SettingsInteractor { }
