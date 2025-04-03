import SwiftUI

@Observable
@MainActor
class OnboardingCompletedPresenter {
    
    private let interactor: OnboardingCompletedInteractor
    private let router: OnboardingCompletedRouter
    
    private(set) var isCompletingProfileSetup: Bool = false
    
    init(interactor: OnboardingCompletedInteractor, router: OnboardingCompletedRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func onViewAppear(delegate: OnboardingCompletedDelegate) {
        interactor.trackScreenEvent(event: Event.onAppear(delegate: delegate))
    }
    
    func onViewDisappear(delegate: OnboardingCompletedDelegate) {
        interactor.trackEvent(event: Event.onDisappear(delegate: delegate))
    }
    
    func onFinishButtonPressed() {
        isCompletingProfileSetup = true
        
        Task {
            do {
//                try await interactor.markOnboardingCompleteForCurrentUser()
//                interactor.trackEvent(event: Event.finishSuccess())
                
                // dismiss screen
                isCompletingProfileSetup = false
                
                // Show tabbar view
                interactor.updateAppState(showTabBarView: true)
            } catch {
                router.showAlert(error: error)
//                interactor.trackEvent(event: Event.finishFail(error: error))
            }
        }
    }
   
}

extension OnboardingCompletedPresenter {
    
    enum Event: LoggableEvent {
        case onAppear(delegate: OnboardingCompletedDelegate)
        case onDisappear(delegate: OnboardingCompletedDelegate)

        var eventName: String {
            switch self {
            case .onAppear:                 return "OnboardingCompletedView_Appear"
            case .onDisappear:              return "OnboardingCompletedView_Disappear"
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
