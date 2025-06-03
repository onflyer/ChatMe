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
        ZStack {
            GradientBackgroundView()
            VStack(spacing: 0) {
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
                   
                titleSection
                
                Spacer()
            }
            .frame(maxHeight: .infinity)
            .padding(.top, 50)
        
            VStack {
                
                Spacer()
                SignInWithAppleButtonView(
                    type: .signIn,
                    style: .white,
                    cornerRadius: 18
                )
                .frame(height: 55)
                .frame(maxWidth: 400)
                .anyButton(.press) {
                    presenter.onSignInApplePressed(delegate: delegate)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                SignInGoogleButtonView(type: .signIn, backgroundColor: .white, foregroundColor: .primary, cornerRadius: 30)
                    .frame(height: 55)
                    .frame(maxWidth: 400)
                    .anyButton(.press) {
                        presenter.onSignInGooglePressed(delegate: delegate)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text("or")
                
                getStartedButton
                
                policyLinks
                    .padding(.top, 10)
                    
            }
            .padding(16)
            .padding(.horizontal, 40)
            
            
            
            
            .onAppear {
                presenter.onViewAppear(delegate: delegate)
            }
            .onDisappear {
                presenter.onViewDisappear(delegate: delegate)
            }
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
        VStack {
            Text("Get started as Guest")
                .callToActionButton(forgroundStyle: .primary, background: .white, cornerRadius: 30)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .anyButton(.press, action: {
                    presenter.onGetStartedPressed()
                })
                .accessibilityIdentifier("StartButton")
                .frame(maxWidth: 400)
                
        }
    }
    
    private var policyLinks: some View {
        HStack(spacing: 8) {
            Link(destination: URL(string: Constants.termsOfServiceUrl)!) {
                Text("Terms of Service")
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            Circle()
                .fill(.primary)
                .frame(width: 4, height: 4)
            Link(destination: URL(string: Constants.privacyPolicyUrl)!) {
                Text("Privacy Policy")
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
        }
        .foregroundStyle(.primary)
    }
    
    private var titleSection: some View {
        VStack(spacing: 8) {
            Text("ChatMe")
                .font(.system(.largeTitle, design: .rounded, weight: .black))
                .fontWeight(.semibold)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Link(destination: URL(string: Constants.githubPage)!) {
                Text("Github @onflyer")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .foregroundStyle(.secondary)
           
        }
    }
}
