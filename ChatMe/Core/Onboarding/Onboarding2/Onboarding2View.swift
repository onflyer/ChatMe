import SwiftUI

struct Onboarding2Delegate {
    var eventParameters: [String: Any]? {
        nil
    }
}

struct Onboarding2View: View {
    
    @State var presenter: Onboarding2Presenter
    let delegate: Onboarding2Delegate
    
    var body: some View {
        VStack {
            headerText
            Spacer()
            content
            Spacer()
            
            Text("Continue")
                .callToActionButton()
                .anyButton(.press) {
                    //presenter.onContinueButtonPressed()
                }
                .accessibilityIdentifier("ContinueButton")
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
    let delegate = Onboarding2Delegate()
    
    return RouterView { router in
        builder.onboarding2ViewView(router: router, delegate: delegate)
    }
}

extension CoreBuilder {
    
    func onboarding2ViewView(router: AnyRouter, delegate: Onboarding2Delegate) -> some View {
        Onboarding2View(
            presenter: Onboarding2Presenter(
                interactor: interactor,
                router: CoreRouter(router: router, builder: self)
            ),
            delegate: delegate
        )
    }
    
}

extension CoreRouter {
    
    func showOnboarding2View(delegate: Onboarding2Delegate) {
        router.showScreen(.push) { router in
            builder.onboarding2ViewView(router: router, delegate: delegate)
        }
    }
    
}

extension Onboarding2View {
    var headerText: some View {
        Text("Second screen title")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.vertical, 50)
            .multilineTextAlignment(.center)
    }
    
    var content: some View {
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
        
    }
    
    
}
