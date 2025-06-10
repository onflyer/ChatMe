//
//  CreateAccountView.swift
//  
//
//  
//
import SwiftUI

struct CreateAccountDelegate {
    var title: String = "Create Account?"
    var subtitle: String = "Don't lose your data! Connect to an SSO provider to save your account."
    var onDidSignIn: ((_ isNewUser: Bool) -> Void)?
    
    var eventParameters: [String: Any]? {
        [
            "delegate_title": title,
            "delegate_subtitle": subtitle
        ]
    }
}

struct CreateAccountView: View {
    
    @State var presenter: CreateAccountPresenter
    var delegate: CreateAccountDelegate = CreateAccountDelegate()
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text(delegate.title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                Text(delegate.subtitle)
                    .font(.body)
                    .lineLimit(4)
                    .minimumScaleFactor(0.5)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            SignInAnonymousButtonView(type: .signIn, style: .whiteOutline)
                .frame(height: 55)
                .frame(maxWidth: 400)
                .anyButton(.press) {
                    presenter.onSignInApplePressed(delegate: delegate)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            
            SignInGoogleButtonView(type: .signIn, backgroundColor: .white, borderColor: .black, foregroundColor: .primary, cornerRadius: 10)
                .frame(height: 55)
                .frame(maxWidth: 400)
                .anyButton(.press) {
                    presenter.onSignInGooglePressed(delegate: delegate)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            
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
      
            Spacer()
        }
        .padding(16)
        .padding(.top, 40)
                
        .onAppear {
            presenter.onViewAppear(delegate: delegate)
        }
        .onDisappear {
            presenter.onViewDisappear(delegate: delegate)
        }
    }
    
}

extension CoreBuilder {
    
    func createAccountView(router: AnyRouter, delegate: CreateAccountDelegate = CreateAccountDelegate()) -> some View {
        CreateAccountView(
            presenter: CreateAccountPresenter(
                interactor: interactor,
                router: CoreRouter(router: router, builder: self)
            ),
            delegate: delegate
        )
    }

}

extension CoreRouter {
    
    func showCreateAccountView(delegate: CreateAccountDelegate, onDismiss: (() -> Void)? = nil) {
        router.showScreen(.sheet, animates: true, onDismiss: onDismiss) { router in
            builder.createAccountView(router: router, delegate: delegate)
        }
//        router.showResizableSheet(sheetDetents: [.medium], selection: nil, showDragIndicator: false, onDismiss: onDismiss) { router in
//            
//        }
    }

}

#Preview {
    let container = DevPreview.shared.container()
    let builder = CoreBuilder(interactor: CoreInteractor(container: container))
        
    return RouterView { router in
        builder.createAccountView(router: router)
            .frame(maxHeight: 400)
            .frame(maxHeight: .infinity, alignment: .bottom)
    }
}
