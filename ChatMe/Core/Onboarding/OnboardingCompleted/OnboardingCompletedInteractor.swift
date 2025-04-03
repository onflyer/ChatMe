import SwiftUI

@MainActor
protocol OnboardingCompletedInteractor {
    func trackEvent(event: LoggableEvent)
    func trackScreenEvent(event: LoggableEvent)
    func updateAppState(showTabBarView: Bool)
}

extension CoreInteractor: OnboardingCompletedInteractor { }
