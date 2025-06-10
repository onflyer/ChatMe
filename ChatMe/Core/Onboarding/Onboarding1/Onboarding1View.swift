import SwiftUI

struct Onboarding1ViewDelegate {
    var eventParameters: [String: Any]? {
        nil
    }
}

struct Onboarding1View: View {
    
    @State var presenter: Onboarding1Presenter
    let delegate: Onboarding1ViewDelegate
    
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
    let delegate = Onboarding1ViewDelegate()
    
    return RouterView { router in
        builder.onboarding1View(router: router, delegate: delegate)
    }
}


extension Onboarding1View {
    var headerText: some View {
        Text("Welcome to ChatMe")
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
                        Text("Welcome to my personal showcase project")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                            
                        Text("Please stay a few minutes and try it out :D")
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
                        Text("This project is built using Swift, SwiftUI and Firebase as a backend service")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                        Text("It was built using modern VIPER architecture that supports decoupled routing in SwiftUI")
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
                        Text("It has most of the features required for most apps on the market")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                        Text("AI API integration, authentication, analytics,onboarding flow, scalable database and more features on the way like purchasing layer, unit testing and a/b testing")
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
