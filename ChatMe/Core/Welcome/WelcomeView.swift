import SwiftUI

struct WelcomeDelegate {
    var eventParameters: [String: Any]? {
        nil
    }
}

struct WelcomeView: View {
    
    @State var presenter: WelcomePresenter
    let delegate: WelcomeDelegate
    
    var body: some View {
        Text("Hello, World!")
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
    
    return RouterView { router in
        builder.welcomeView(router: router, delegate: delegate)
    }
}


extension CoreRouter {
    
    
    
}
