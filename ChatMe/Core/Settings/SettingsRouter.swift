//
//  SettingsRouter.swift
//  
//
//  
//
import SwiftUI

@MainActor
protocol SettingsRouter {
    func showAlert(title: String, subtitle: String?, buttons: @escaping (@Sendable () -> AnyView))
    func showAlert(error: Error)
    func dismissScreen()
    func showCreateAccountView(delegate: CreateAccountDelegate, onDismiss: (() -> Void)?)

}

extension CoreRouter: SettingsRouter { }
