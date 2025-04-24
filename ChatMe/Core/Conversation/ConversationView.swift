import SwiftUI

struct ConversationDelegate {
    var eventParameters: [String: Any]? {
        nil
    }
}

struct ConversationView: View {
    
    @State var presenter: ConversationPresenter
    let delegate: ConversationDelegate
    
    var body: some View {
        Text("Conversation View")
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
    let delegate = ConversationDelegate()
    
    return RouterView { router in
        builder.conversationView(router: router, delegate: delegate)
    }
}


