//
//  CoreBuilder.swift
//  TMDB VIPER
//
//  Created by Aleksandar Milidrag on 22. 12. 2024..
//

import SwiftUI

@MainActor
struct CoreBuilder {
    let interactor: CoreInteractor
    
    func appView() -> some View {
        AppView(
            presenter: AppViewPresenter(
                interactor: interactor
            ),
            tabbarView: {
                tabbarView()       },
            onboardingView: {
                welcomeView()
            }
        )
    }
    
    func welcomeView(delegate: WelcomeDelegate = WelcomeDelegate()) -> some View {
        RouterView { router in
            WelcomeView(
                presenter: WelcomePresenter(
                    interactor: interactor,
                    router: CoreRouter(router: router, builder: self)
                ),
                delegate: delegate
            )
        }
    }
    
    func onboarding1View(router: AnyRouter, delegate: Onboarding1ViewDelegate) -> some View {
        Onboarding1View(
            presenter: Onboarding1Presenter(
                interactor: interactor,
                router: CoreRouter(router: router, builder: self)
            ),
            delegate: delegate
        )
    }
    
    func onboarding2View(router: AnyRouter, delegate: Onboarding2ViewDelegate) -> some View {
        Onboarding2View(
            presenter: Onboarding2Presenter(
                interactor: interactor,
                router: CoreRouter(router: router, builder: self)
            ),
            delegate: delegate
        )
    }
    
    func onboardingCompletedView(router: AnyRouter, delegate: OnboardingCompletedDelegate) -> some View {
        OnboardingCompletedView(
            presenter: OnboardingCompletedPresenter(
                interactor: interactor,
                router: CoreRouter(router: router, builder: self)
            ),
            delegate: delegate
        )
    }
    
    func tabbarView() -> some View {
        TabBarView(
            tabs: [
                TabBarScreen(title: "Conversations", systemImage: "text.justify.left", screen: {
                    RouterView { router in
                        conversationView(router: router, delegate: ConversationDelegate())
                    }
                    .any()
                }),
                TabBarScreen(title: "Chat", systemImage: "bubble.left.and.bubble.right.fill", screen: {
                    RouterView { router in
                        streamChatView(router: router, delegate: StreamChatDelegate())
                    }
                    .any()
                }),
                TabBarScreen(title: "Profile", systemImage: "person.fill", screen: {
                    RouterView { router in
                        profileView(router: router, delegate: ProfileDelegate())
                    }
                    .any()
                })
            ]
        )
    }
    
    func conversationView(router: AnyRouter, delegate: ConversationDelegate) -> some View {
        ConversationView(
            presenter: ConversationPresenter(
                interactor: interactor,
                router: CoreRouter(router: router, builder: self)
            ),
            delegate: delegate
        )
    }
    
    func profileView(router: AnyRouter, delegate: ProfileDelegate = ProfileDelegate()) -> some View {
        ProfileView(
            presenter: ProfilePresenter(
                interactor: interactor,
                router: CoreRouter(router: router, builder: self)
            ),
            delegate: delegate
        )
    }
    
    func settingsView(router: AnyRouter) -> some View {
        SettingsView(
            presenter: SettingsPresenter(
                interactor: interactor,
                router: CoreRouter(router: router, builder: self)
            )
        )
    }
    
    func chatView(router: AnyRouter, delegate: ChatDelegate) -> some View {
        ChatView(
            presenter: ChatPresenter(
                interactor: interactor,
                router: CoreRouter(router: router, builder: self)
            ),
            delegate: delegate
        )
    }
    
    func streamChatView(router: AnyRouter, delegate: StreamChatDelegate) -> some View {
        StreamChatView(
            presenter: ChatStreamPresenter(
                interactor: interactor,
                router: CoreRouter(router: router, builder: self)
            ),
            delegate: delegate
        )
    }
    
    
}
