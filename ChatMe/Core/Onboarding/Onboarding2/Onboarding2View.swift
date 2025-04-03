import SwiftUI

struct Onboarding2ViewDelegate {
    var eventParameters: [String: Any]? {
        nil
    }
}

struct Onboarding2View: View {
    
    @State var presenter: Onboarding2Presenter
    let delegate: Onboarding2ViewDelegate
    
    var body: some View {
        VStack {
            headerText
            Spacer()
            content
            Spacer()
            
            Text("Continue")
                .callToActionButton()
                .anyButton(.press) {
                    presenter.onContinueButtonPressed()
                }
                .accessibilityIdentifier("ContinueButton")
        }
        .padding(24)
        .toolbar(.hidden, for: .navigationBar)
        
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
    let delegate = Onboarding2ViewDelegate()
    
    return RouterView { router in
        builder.onboarding2View(router: router, delegate: delegate)
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
