//
//  SettingsRouter.swift
//  
//
//  
//
import SwiftUI

@MainActor
protocol SettingsRouter {
    func showAlert(_ option: DialogOption, title: String, subtitle: String?, buttons: (@Sendable () -> AnyView)?)
    func showAlert(error: Error)
    func dismissScreen()
}

extension CoreRouter: SettingsRouter { }
