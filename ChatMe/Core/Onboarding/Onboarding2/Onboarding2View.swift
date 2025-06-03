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
        ZStack {
            GradientBackgroundView()
            VStack {
                headerText
                Spacer()
                content
                Spacer()
                
                Text("Continue")
                    .callToActionButton(forgroundStyle: .primary, background: .white, cornerRadius: 30)
                    .padding(.horizontal, 40)
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
        Text("Core features")
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
                        Text("Complete authentication and login flow")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                        Text("User can create and login with multiple providers, like apple and google at the same time, login status is saved to user defaults and uploaded to firestore")
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
                        Text("Complete backend data syncronization")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                        Text("Everything is saved to Firebase database, collections of users, conversations with AI, and every chat message in the subcollection with listeners attached for real time updates")
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
                        Text("Gemini AI API integration")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                        Text("We can prompt the latest google LLMs and get blazing fast responses leveraging async stream for better user experience")
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

