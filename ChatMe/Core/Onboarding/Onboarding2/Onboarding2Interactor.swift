import SwiftUI

@MainActor
protocol Onboarding2Interactor {
    func trackEvent(event: LoggableEvent)
    func trackScreenEvent(event: LoggableEvent)
}

extension CoreInteractor: Onboarding2Interactor { }
