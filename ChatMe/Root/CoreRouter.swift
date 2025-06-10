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
//typealias DialogOption = SwiftfulRouting.DialogOption

@MainActor
struct CoreRouter {
    
    let router: AnyRouter
    let builder: CoreBuilder
    
    
    func dismissModal(id: String) {
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
    
    func showChatView(delegate: ChatDelegate) {
        router.showScreen(.push) { router in
            builder.chatView(router: router, delegate: delegate)
        }
    }
    
    func showStreamChatView(delegate: StreamChatDelegate) {
        router.showScreen(.push) { router in
            builder.streamChatView(router: router, delegate: delegate)
        }
    }
        
    //MARK: Alerts
    
    func showAlert(title: String, subtitle: String?, buttons: @escaping (@Sendable () -> AnyView)) {
        router.showAlert(.alert, location: .currentScreen, title: title, subtitle: subtitle, buttons: buttons)
        
    }
    
    func showAlert(title: String, subtitle: String?) {
        router.showAlert(.alert, location: .currentScreen, title: title, subtitle: subtitle)
        
    }
    
    func showConfirmationDialog(title: String, subtitle: String?, buttons: @escaping (@Sendable () -> AnyView)) {
        router.showAlert(.confirmationDialog, location: .currentScreen, title: title, subtitle: subtitle, buttons: buttons )
        
    }
    
    
    func showSimpleAlert(title: String, subtitle: String?) {
        router.showAlert(.alert, title: title, subtitle: subtitle)
    }
    
    func showAlert(error: Error) {
        router.showAlert(.alert, title: "Error", subtitle: error.localizedDescription)
    }
    
    func dismissAlert() {
        router.dismissAlert()
    }
    
}
