//
//  Dependencies.swift
//  TMDB_VIPER
//
//  Created by Aleksandar Milidrag on 21. 12. 2024.
//

import SwiftUI


@MainActor
struct Dependencies {
    let container: DependencyContainer
    
    
    init() {
        let container = DependencyContainer()
        self.container = container
    }
}

@MainActor
class DevPreview {
    static let shared = DevPreview()
    
    init() {
      
    }
    
    func container() -> DependencyContainer {
        let container = DependencyContainer()
        
        return container
    }
}

