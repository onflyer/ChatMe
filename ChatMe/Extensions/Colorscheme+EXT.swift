//
//  Colorscheme+EXT.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 6. 4. 2025..
//
import SwiftUI

extension ColorScheme {
    
    var backgroundPrimary: Color {
        self == .dark ? Color(uiColor: .secondarySystemBackground) : Color(uiColor: .systemBackground)
    }
    
    var backgroundSecondary: Color {
        self == .dark ? Color(uiColor: .systemBackground) : Color(uiColor: .secondarySystemBackground)
    }
    
}
