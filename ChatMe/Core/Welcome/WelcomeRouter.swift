import SwiftUI

@MainActor
protocol WelcomeRouter {
    func showOnboarding1View(delegate: Onboarding1ViewDelegate)
}

extension CoreRouter: WelcomeRouter { }
