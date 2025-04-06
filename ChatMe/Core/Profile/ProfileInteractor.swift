import SwiftUI

@MainActor
protocol ProfileInteractor {
    func trackEvent(event: LoggableEvent)
    func trackScreenEvent(event: LoggableEvent)
}

extension CoreInteractor: ProfileInteractor { }
