import SwiftUI

struct WelcomeDelegate {
    var onDidSignIn: ((_ isNewUser: Bool) -> Void)?
    var eventParameters: [String: Any]? {
        nil
    }
}

struct WelcomeView: View {
    
    @State var presenter: WelcomePresenter
    let delegate: WelcomeDelegate
    
    var body: some View {
        VStack {
            SignInWithAppleButtonView(
                type: .signIn,
                style: .whiteOutline,
                cornerRadius: 10
            )
            .frame(height: 55)
            .frame(maxWidth: 400)
            .anyButton(.press) {
                presenter.onSignInApplePressed(delegate: delegate)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Welcome to ChatMe")
            getStartedButton
        }
        .padding(16)
       
        
        .onAppear {
            presenter.onViewAppear(delegate: delegate)
        }
        .onDisappear {
            presenter.onViewDisappear(delegate: delegate)
        }
    }
}

#Preview {
    let container = DevPreview.shared.container()
    let interactor = CoreInteractor(container: container)
    let builder = CoreBuilder(interactor: interactor)
    let delegate = WelcomeDelegate()
    
    RouterView { router in
        builder.welcomeView(delegate: delegate)
    }
}

extension WelcomeView {
    private var getStartedButton: some View {
        VStack(spacing: 8) {
            Text("Get Started")
                .callToActionButton()
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .anyButton(.press, action: {
                    presenter.onGetStartedPressed()
                })
                .accessibilityIdentifier("StartButton")
                .frame(maxWidth: 500)
        }
    }
}
