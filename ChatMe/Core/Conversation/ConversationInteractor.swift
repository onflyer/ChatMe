import SwiftUI

@MainActor
protocol ConversationInteractor {
    func trackEvent(event: LoggableEvent)
    func trackScreenEvent(event: LoggableEvent)
}

extension CoreInteractor: ConversationInteractor { }
