//
//  AppView.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 30. 3. 2025..
//
import SwiftUI

struct AppView<TabbarView: View, OnboardingView: View>: View {

    @State var presenter: AppViewPresenter
    var tabbarView: () -> TabbarView
    var onboardingView: () -> OnboardingView

    var body: some View {
        RootView(
            delegate: RootDelegate(
                onApplicationDidAppear: nil,
                onApplicationWillEnterForeground: { _ in
                    Task {
                        await presenter.checkUserStatus()
                    }
                },
                onApplicationDidBecomeActive: nil,
                onApplicationWillResignActive: nil,
                onApplicationDidEnterBackground: nil,
                onApplicationWillTerminate: nil
            ),
            content: {
                AppViewBuilder(
                    showTabBar: presenter.showTabBar,
                    tabbarView: {
                        tabbarView()
                    },
                    onboardingView: {
                        onboardingView()
                    }
                )
                .task {
                   await presenter.checkUserStatus()
                }
                .task {
                    try? await Task.sleep(for: .seconds(2))
//                    await presenter.showATTPromptIfNeeded()
                }
                .onChange(of: presenter.showTabBar) { _, showTabBar in
                    if !showTabBar {
                        Task {
                            await presenter.checkUserStatus()
                        }
                    }
                }
            }
        )
//        .onNotificationRecieved(name: .fcmToken, action: { notification in
//            presenter.onFCMTokenRecieved(notification: notification)
//        })
        .onAppear {
            presenter.onViewAppear()
        }
        .onDisappear {
            presenter.onViewDisappear()
        }
    }
}

#Preview("AppView - Tabbar") {
    let container = DevPreview.shared.container()
    container.register(AppState.self, service: AppState(showTabBar: true))
    let builder = CoreBuilder(interactor: CoreInteractor(container: container))
    
    return builder.appView()
}
#Preview("AppView - Onboarding") {
    let container = DevPreview.shared.container()
//    container.register(UserManager.self, service: UserManager(services: MockUserServices(user: nil)))
    container.register(AuthManager.self, service: AuthManager(service: MockAuthService(user: nil)))
    container.register(AppState.self, service: AppState(showTabBar: false))
    let builder = CoreBuilder(interactor: CoreInteractor(container: container))

    return builder.appView()
}


