import SwiftUI

@MainActor
protocol Onboarding1Router {
    func showOnboarding2View(delegate: Onboarding2ViewDelegate)
}

extension CoreRouter: Onboarding1Router { }
