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
    
    let router: Router
    let builder: CoreBuilder
    
    
    func dismissModal(id: String?) {
        router.dismissModal(id: id)
    }
    
    func dismissScreen() {
        router.dismissScreen()
    }
    
    
    
    
}
