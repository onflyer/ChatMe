import SwiftUI

struct ChatDelegate {
    var eventParameters: [String: Any]? {
        nil
    }
}

struct ChatView: View {
    
    @State var presenter: ChatPresenter
    let delegate: ChatDelegate
    
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
    let delegate = ChatDelegate()
    
    return RouterView { router in
        builder.chatView(router: router, delegate: delegate)
    }
}
