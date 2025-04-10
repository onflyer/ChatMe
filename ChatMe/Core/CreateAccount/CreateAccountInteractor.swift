//
//  CreateAccountInteractor.swift
//  
//
//  
//
@MainActor
protocol CreateAccountInteractor {
    func trackEvent(event: LoggableEvent)
    func trackScreenEvent(event: LoggableEvent)
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool)
    func signInGoogle() async throws -> (user: UserAuthInfo, isNewUser: Bool)
    func logIn(user: UserAuthInfo, isNewUser: Bool) async throws
}

extension CoreInteractor: CreateAccountInteractor { }
