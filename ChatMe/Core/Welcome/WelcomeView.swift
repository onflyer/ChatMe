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
        VStack {
                       Text("Welcome to ChatME")
                           .font(.largeTitle)
                           .fontWeight(.bold)
                           .padding(.vertical, 50)
                           .multilineTextAlignment(.center)
                       Spacer()
                       VStack {
                               VStack(alignment: .leading) {
                                   HStack {
                                           Image(systemName: "bubble.left.and.bubble.right.fill")
                                               .resizable()
                                               .aspectRatio(contentMode: .fit)
                                               .frame(width: 45, alignment: .center)
                                               .clipped()
                                               .foregroundColor(.primary)
                                               .padding(.trailing, 15)
                                               .padding(.vertical, 10)
                                       
                                       VStack(alignment: .leading) {
                                           Text("Title")
                                               .fontWeight(.bold)
                                               .font(.system(size: 16))
                                           Text("Description")
                                               .font(.system(size: 15))
                                       }
                                       Spacer()
                                   }
                               }
                               .padding(.horizontal,20)
                               .padding(.bottom, 20)
                           
                       }
                       .padding(.bottom, 30)
                       Spacer()
                       VStack {
                           ZStack {
                               Rectangle()
                                   .foregroundColor(.primary)
                                   .cornerRadius(12)
                                   .frame(height: 54)
                               Text("Continue")
                                   .fontWeight(.bold)
                                   .foregroundColor(.white)
                           }
                       }
                       .padding(.top, 15)
                       .padding(.bottom, 50)
                       .padding(.horizontal,15)
                   }
                   .padding()
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

