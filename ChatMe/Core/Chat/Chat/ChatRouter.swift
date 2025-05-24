import SwiftUI

@MainActor
protocol ChatRouter {
    func dismissScreen()
    func showAlert(error: Error)
    func showAlert(_ option: DialogOption, title: String, subtitle: String?, buttons: (@Sendable () -> AnyView)?) 
}

extension CoreRouter: ChatRouter { }
