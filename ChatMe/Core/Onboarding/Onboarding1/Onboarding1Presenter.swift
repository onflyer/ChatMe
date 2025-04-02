import SwiftUI

@Observable
@MainActor
class Onboarding1Presenter {
    
    private let interactor: Onboarding1Interactor 
    private let router: Onboarding1Router
    
    init(interactor: Onboarding1Interactor, router: Onboarding1Router) {
        self.interactor = interactor
        self.router = router
    }
    
    func onViewAppear(delegate: Onboarding1ViewDelegate) {
        interactor.trackScreenEvent(event: Event.onAppear(delegate: delegate))
    }
    
    func onViewDisappear(delegate: Onboarding1ViewDelegate) {
        interactor.trackEvent(event: Event.onDisappear(delegate: delegate))
    }
}

extension Onboarding1Presenter {
    
    enum Event: LoggableEvent {
        case onAppear(delegate: Onboarding1ViewDelegate)
        case onDisappear(delegate: Onboarding1ViewDelegate)

        var eventName: String {
            switch self {
            case .onAppear:                 return "Onboarding1View_Appear"
            case .onDisappear:              return "Onboarding1View_Disappear"
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
