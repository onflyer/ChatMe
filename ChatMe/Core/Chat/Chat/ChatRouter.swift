import SwiftUI

@MainActor
protocol ChatRouter {
    func showAlert(error: Error)
}

extension CoreRouter: ChatRouter { }
