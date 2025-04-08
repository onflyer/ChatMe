import SwiftUI

@Observable
@MainActor
class WelcomePresenter {
    
    private let interactor: WelcomeInteractor
    private let router: WelcomeRouter
    
    init(interactor: WelcomeInteractor, router: WelcomeRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func onViewAppear(delegate: WelcomeDelegate) {
        interactor.trackScreenEvent(event: Event.onAppear(delegate: delegate))
    }
    
    func onViewDisappear(delegate: WelcomeDelegate) {
        interactor.trackEvent(event: Event.onDisappear(delegate: delegate))
    }
    
    func onGetStartedPressed() {
        router.showOnboarding1View(delegate: Onboarding1ViewDelegate())
    }
}

extension WelcomePresenter {
    
    enum Event: LoggableEvent {
        case onAppear(delegate: WelcomeDelegate)
        case onDisappear(delegate: WelcomeDelegate)
        case appleAuthStart
        case appleAuthSuccess(user: UserAuthInfo, isNewUser: Bool)
        case appleAuthLoginSuccess(user: UserAuthInfo, isNewUser: Bool)
        case appleAuthFail(error: Error)


        var eventName: String {
            switch self {
            case .onAppear:                 return "WelcomeView_Appear"
            case .onDisappear:              return "WelcomeView_Disappear"
            case .appleAuthStart:          return "CreateAccountView_AppleAuth_Start"
            case .appleAuthSuccess:        return "CreateAccountView_AppleAuth_Success"
            case .appleAuthLoginSuccess:   return "CreateAccountView_AppleAuth_LoginSuccess"
            case .appleAuthFail:           return "CreateAccountView_AppleAuth_Fail"
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            case .onAppear(delegate: let delegate), .onDisappear(delegate: let delegate):
                return delegate.eventParameters
            case .appleAuthSuccess(user: let user, isNewUser: let isNewUser),
                    .appleAuthLoginSuccess(user: let user, isNewUser: let isNewUser):
                var dict = user.eventParameters
                dict["is_new_user"] = isNewUser
                return dict
            case .appleAuthFail(error: let error):
                return error.eventParameters
            default:
                return nil
            }
        }
        
        var type: LogType {
            switch self {
            case .appleAuthFail:
                return .severe
            default:
                return .analytic
            }
        }
    }

}
