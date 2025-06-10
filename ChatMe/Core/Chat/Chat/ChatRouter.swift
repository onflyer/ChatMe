import SwiftUI

@MainActor
protocol ChatRouter {
    func dismissScreen()
    func showAlert(error: Error)
    func showAlert(title: String, subtitle: String?)
    func showAlert(title: String, subtitle: String?, buttons: @escaping (@Sendable () -> AnyView))
    func showConfirmationDialog(title: String, subtitle: String?, buttons: @escaping (@Sendable () -> AnyView))
}

extension CoreRouter: ChatRouter { }
