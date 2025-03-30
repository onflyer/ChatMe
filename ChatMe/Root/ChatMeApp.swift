//
//  ChatMeApp.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 28. 3. 2025..
//

import SwiftUI

@main
struct ChatMeApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            delegate.builder.appView()
        }
    }
}
