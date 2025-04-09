import SwiftUI

@MainActor
protocol OnboardingCompletedInteractor {
    func trackEvent(event: LoggableEvent)
    func trackScreenEvent(event: LoggableEvent)
    func updateAppState(showTabBarView: Bool)
    func saveOnboardingComplete() async throws
}

extension CoreInteractor: OnboardingCompletedInteractor { }
