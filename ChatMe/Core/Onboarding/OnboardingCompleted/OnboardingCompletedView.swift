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
        ZStack {
            GradientBackgroundView()
            VStack {
                headerText
                Spacer()
                content
                Spacer()
                
                Text("Finish")
                    .callToActionButton(forgroundStyle: .primary, background: .white, cornerRadius: 30)
                    .padding(.horizontal, 40)
                    .anyButton(.press) {
                        presenter.onFinishButtonPressed()
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
        }    }
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
        Text("Introduction completed")
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
                        Text("Click on Chat tab bar icon to start a conversation")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                        Text("Click on the pencil in top trailing edge to start new conversation and save previous one")
                            .font(.system(size: 15))
                    }
                    
                    
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
                        Text("Conversation tab bar contains all conversations")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                        Text("Title of conversation is summary of the complete conversation and it updates on exit of the current conversation")
                            .font(.system(size: 15))
                    }
                    
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
                        Text("Messages subcollection")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                        Text("Every message is saved to firestore separately as its own document, for better user experience i introduced async stream to recieve response in chunks")
                            .font(.system(size: 15))
                    }
                }
            }
            .padding(.horizontal,20)
            .padding(.bottom, 20)
            
            
            
        }
        .padding(.bottom, 30)
        
    }
    
    
}
