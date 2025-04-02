//
//  CoreRouter.swift
//  TMDB VIPER
//
//  Created by Aleksandar Milidrag on 22. 12. 2024.
//

import Foundation
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
    
    func showOnboarding1View(delegate: Onboarding1Delegate) {
        router.showScreen(.push) { router in
            builder.onboarding1View(router: router, delegate: delegate)
        }
    }
    
    
}
