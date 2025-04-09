import SwiftUI

@MainActor
protocol WelcomeInteractor {
    func trackEvent(event: LoggableEvent)
    func trackScreenEvent(event: LoggableEvent)
    func updateAppState(showTabBarView: Bool)
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool)
}

extension CoreInteractor: WelcomeInteractor { }
