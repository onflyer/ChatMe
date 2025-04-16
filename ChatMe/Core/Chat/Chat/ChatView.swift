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
        VStack(spacing: 0) {
            scrollViewSection
            textFieldSection
        }
        .navigationTitle("Chat")
        .toolbarTitleDisplayMode(.inline)
            .onAppear {
                presenter.onViewAppear(delegate: delegate)
            }
            .onDisappear {
                presenter.onViewDisappear(delegate: delegate)
            }
    }
    
    private var scrollViewSection: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(presenter.chatMessages) { message in
                    let isCurrentUser = message.content?.role == .user
                    ChatBubbleViewBuilder(
                        message: message,
                        isCurrentUser: isCurrentUser,
                        imageName: nil,
                        onImagePressed: nil
                    )
                    .id(message.id)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(8)
            .rotationEffect(.degrees(180))
        }
        .rotationEffect(.degrees(180))
        .scrollPosition(id: $presenter.scrollPosition, anchor: .center)
        .animation(.default, value: presenter.chatMessages.count)
        .animation(.default, value: presenter.scrollPosition)
    }
    
    private var textFieldSection: some View {
        TextField("Say something...", text: $presenter.textFieldText)
            .keyboardType(.alphabet)
            .autocorrectionDisabled()
            .padding(12)
            .padding(.trailing, 60)
            .overlay(
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 15))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding(.horizontal, 5)
                    .anyButton(.plain, action: {
                        presenter.onSendMessagePressed()
                    })
                
                , alignment: .trailing
            )
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(Color(uiColor: .systemBackground))
                    
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                }
            )
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color(uiColor: .secondarySystemBackground))
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
