import SwiftUI

@Observable
@MainActor
class ConversationPresenter {
    
    private let interactor: ConversationInteractor
    private let router: ConversationRouter
    
    init(interactor: ConversationInteractor, router: ConversationRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func onViewAppear(delegate: ConversationDelegate) {
        interactor.trackScreenEvent(event: Event.onAppear(delegate: delegate))
    }
    
    func onViewDisappear(delegate: ConversationDelegate) {
        interactor.trackEvent(event: Event.onDisappear(delegate: delegate))
    }
}

extension ConversationPresenter {
    
    enum Event: LoggableEvent {
        case onAppear(delegate: ConversationDelegate)
        case onDisappear(delegate: ConversationDelegate)

        var eventName: String {
            switch self {
            case .onAppear:                 return "ConversationView_Appear"
            case .onDisappear:              return "ConversationView_Disappear"
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            case .onAppear(delegate: let delegate), .onDisappear(delegate: let delegate):
                return delegate.eventParameters
//            default:
//                return nil
            }
        }
        
        var type: LogType {
            switch self {
            default:
                return .analytic
            }
        }
    }

}
