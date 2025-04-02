import SwiftUI

@Observable
@MainActor
class Onboarding2Presenter {
    
    private let interactor: Onboarding2Interactor
    private let router: Onboarding2Router
    
    init(interactor: Onboarding2Interactor, router: Onboarding2Router) {
        self.interactor = interactor
        self.router = router
    }
    
    func onViewAppear(delegate: Onboarding2Delegate) {
        interactor.trackScreenEvent(event: Event.onAppear(delegate: delegate))
    }
    
    func onViewDisappear(delegate: Onboarding2Delegate) {
        interactor.trackEvent(event: Event.onDisappear(delegate: delegate))
    }
}

extension Onboarding2Presenter {
    
    enum Event: LoggableEvent {
        case onAppear(delegate: Onboarding2Delegate)
        case onDisappear(delegate: Onboarding2Delegate)

        var eventName: String {
            switch self {
            case .onAppear:                 return "Onboarding2View_Appear"
            case .onDisappear:              return "Onboarding2View_Disappear"
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
