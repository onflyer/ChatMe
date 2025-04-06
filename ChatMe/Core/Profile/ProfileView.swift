import SwiftUI

struct ProfileDelegate {
    var eventParameters: [String: Any]? {
        nil
    }
}

struct ProfileView: View {
    
    @State var presenter: ProfilePresenter
    let delegate: ProfileDelegate
    
    var body: some View {
        List {
            Text("Hello, world!")
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                settingsButton
            }
        }
        .onAppear {
            presenter.onViewAppear(delegate: delegate)
        }
        .onDisappear {
            presenter.onViewDisappear(delegate: delegate)
        }
    }
    
    private var settingsButton: some View {
        Image(systemName: "gear")
            .font(.headline)
            .foregroundStyle(.blue)
            .anyButton {
                presenter.onSettingsButtonPressed()
            }
    }
}

#Preview {
    let container = DevPreview.shared.container()
    let builder = CoreBuilder(interactor: CoreInteractor(container: container))
    let delegate = ProfileDelegate()
    
    return RouterView { router in
        builder.profileView(router: router, delegate: delegate)
    }
}
