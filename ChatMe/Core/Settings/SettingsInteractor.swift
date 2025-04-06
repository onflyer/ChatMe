//
//  SettingsInteractor.swift
//  
//
//  
//

@MainActor
protocol SettingsInteractor {
    var auth: UserAuthInfo? { get }
    func signOut() async throws
    func deleteAccount() async throws
    func updateAppState(showTabBarView: Bool)
    func trackEvent(event: LoggableEvent)
    func trackScreenEvent(event: LoggableEvent)
}

extension CoreInteractor: SettingsInteractor { }
