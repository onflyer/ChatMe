//
//  AppDelegate.swift
//  TMDB VIPER
//
//  Created by Aleksandar Milidrag on 22. 12. 2024..
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    var dependencies: Dependencies!
    var builder: CoreBuilder!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        dependencies = Dependencies()
        builder = CoreBuilder(interactor: CoreInteractor(container: dependencies.container))
        return true
    }    
}
