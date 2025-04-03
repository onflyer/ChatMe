import SwiftUI

@MainActor
protocol Onboarding2Router {
    func showOnboardingCompletedView(delegate: OnboardingCompletedDelegate)
}

extension CoreRouter: Onboarding2Router { }
