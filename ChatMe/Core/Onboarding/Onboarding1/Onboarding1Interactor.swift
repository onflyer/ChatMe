import SwiftUI

@MainActor
protocol Onboarding1Interactor {
    func trackEvent(event: LoggableEvent)
    func trackScreenEvent(event: LoggableEvent)
}

extension CoreInteractor: Onboarding1Interactor { }
