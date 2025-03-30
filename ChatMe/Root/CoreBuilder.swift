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
                Text(verbatim: "ONBOARDING View")
            }
        )
    }
    
    func tabbarView() -> some View {
        TabBarView(
            tabs: [
                TabBarScreen(title: "Home", systemImage: "house.fill", screen: {
                    RouterView { router in
//                        homeView(router: router, delegate: HomeDelegate())
                    }
                    .any()
                }),
                TabBarScreen(title: "Beta", systemImage: "heart.fill", screen: {
                    RouterView { _ in
                        Text("Beta")
                    }
                    .any()
                }),
                TabBarScreen(title: "Profile", systemImage: "person.fill", screen: {
                    RouterView { router in
//                        profileView(router: router, delegate: ProfileDelegate())
                    }
                    .any()
                })
            ]
        )
    }
    
}
