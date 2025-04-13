import SwiftUI

@Observable
@MainActor
class ChatPresenter {
    
    private let interactor: ChatInteractor
    private let router: ChatRouter
    
    init(interactor: ChatInteractor, router: ChatRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func onViewAppear(delegate: ChatDelegate) {
        interactor.trackScreenEvent(event: Event.onAppear(delegate: delegate))
    }
    
    func onViewDisappear(delegate: ChatDelegate) {
        interactor.trackEvent(event: Event.onDisappear(delegate: delegate))
    }
}

extension ChatPresenter {
    
    enum Event: LoggableEvent {
        case onAppear(delegate: ChatDelegate)
        case onDisappear(delegate: ChatDelegate)

        var eventName: String {
            switch self {
            case .onAppear:                 return "ChatView_Appear"
            case .onDisappear:              return "ChatView_Disappear"
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
