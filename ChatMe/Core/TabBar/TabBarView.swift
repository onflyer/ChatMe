//
//  TabBarView.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 30. 3. 2025..
//

import SwiftUI

struct TabBarScreen: Identifiable {
    var id: String {
        title
    }
    
    let title: String
    let systemImage: String
    @ViewBuilder var screen: () -> AnyView
}

struct TabBarView: View {
    
    var tabs: [TabBarScreen]

    var body: some View {
        TabView {
            ForEach(tabs) { tab in
                tab.screen()
                    .tabItem {
                        Label(tab.title, systemImage: tab.systemImage)
                    }
            }
        }
    }
}

#Preview("Fake tabs") {
    TabBarView(tabs: [
        TabBarScreen(title: "Explore", systemImage: "eyes", screen: {
            Color.red.any()
        }),
        TabBarScreen(title: "Chats", systemImage: "bubble.left.and.bubble.right.fill", screen: {
            Color.blue.any()
        }),
        TabBarScreen(title: "Profile", systemImage: "person.fill", screen: {
            Color.green.any()
        })
    ])
}

#Preview("Real tabs") {
    let container = DevPreview.shared.container()
    let builder = CoreBuilder(interactor: CoreInteractor(container: container))
    
    return builder.tabbarView()
}

