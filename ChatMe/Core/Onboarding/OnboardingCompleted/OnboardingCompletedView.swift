import SwiftUI

struct OnboardingCompletedDelegate {
    var eventParameters: [String: Any]? {
        nil
    }
}

struct OnboardingCompletedView: View {
    
    @State var presenter: OnboardingCompletedPresenter
    let delegate: OnboardingCompletedDelegate
    
    var body: some View {
        VStack {
            headerText
            Spacer()
            content
            Spacer()
            
                .safeAreaInset(edge: .bottom, content: {
                    AsyncCallToActionButton(
                        isLoading: presenter.isCompletingProfileSetup,
                        title: "Finish",
                        action: {
                            
                        }
                    )
                    .accessibilityIdentifier("FinishButton")
                })

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
    let delegate = OnboardingCompletedDelegate()
    
    return RouterView { router in
        builder.onboardingCompletedView(router: router, delegate: delegate)
    }
}



extension OnboardingCompletedView {
    var headerText: some View {
        Text("Finish setup screen title")
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
