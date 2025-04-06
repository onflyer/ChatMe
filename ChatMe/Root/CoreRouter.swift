//
//  CoreRouter.swift
//  TMDB VIPER
//
//  Created by Aleksandar Milidrag on 22. 12. 2024.
//

import SwiftUI
import SwiftfulRouting

typealias RouterView = SwiftfulRouting.RouterView
typealias AnyRouter = SwiftfulRouting.AnyRouter
typealias DialogOption = SwiftfulRouting.DialogOption

@MainActor
struct CoreRouter {
    
    let router: AnyRouter
    let builder: CoreBuilder
    
    
    func dismissModal(id: String?) {
        router.dismissModal(id: id)
    }
    
    func dismissScreen() {
        router.dismissScreen()
    }
    
    
    
    func showOnboarding1View(delegate: Onboarding1ViewDelegate) {
        router.showScreen(.push) { router in
            builder.onboarding1View(router: router, delegate: delegate)
        }
    }
    
    func showOnboarding2View(delegate: Onboarding2ViewDelegate) {
        router.showScreen(.push) { router in
            builder.onboarding2View(router: router, delegate: delegate)
        }
    }
    
    func showOnboardingCompletedView(delegate: OnboardingCompletedDelegate) {
        router.showScreen(.push) { router in
            builder.onboardingCompletedView(router: router, delegate: delegate)
        }
    }
    
    func showProfileView(delegate: ProfileDelegate) {
        router.showScreen(.push) { router in
            builder.profileView(router: router, delegate: delegate)
        }
    }
    
    func showSettingsView() {
        router.showScreen(.sheet) { router in
            builder.settingsView(router: router)
        }
    }
    
    //MARK: Alerts
    
    func showAlert(_ option: DialogOption, title: String, subtitle: String?, buttons: (@Sendable () -> AnyView)?) {
        router.showAlert(option, title: title, subtitle: subtitle, alert: {
            buttons?()
        })
    }
    
    func showSimpleAlert(title: String, subtitle: String?) {
        router.showAlert(.alert, title: title, subtitle: subtitle, alert: { })
    }
    
    func showAlert(error: Error) {
        router.showAlert(.alert, title: "Error", subtitle: error.localizedDescription, alert: { })
    }
    
    func dismissAlert() {
        router.dismissAlert()
    }
}
