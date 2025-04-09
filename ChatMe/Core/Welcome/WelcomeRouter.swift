import SwiftUI

@MainActor
protocol WelcomeRouter {
    func showOnboarding1View(delegate: Onboarding1ViewDelegate)
    func showAlert(error: Error)
}

extension CoreRouter: WelcomeRouter { }
