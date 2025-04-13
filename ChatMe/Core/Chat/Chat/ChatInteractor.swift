import SwiftUI

@MainActor
protocol ChatInteractor {
    func trackEvent(event: LoggableEvent)
    func trackScreenEvent(event: LoggableEvent)
}

extension CoreInteractor: ChatInteractor { }
