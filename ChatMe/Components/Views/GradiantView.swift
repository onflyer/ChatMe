//
//  GradiantView.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 3. 6. 2025..
//

import SwiftUI

struct GradientBackgroundView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.70, green: 0.90, blue: 0.95),  // Approximate color for the top
                    Color(red: 0.60, green: 0.85, blue: 0.75)   // Approximate color for the bottom
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            RadialGradient(
                gradient: Gradient(colors: [
                    Color.white.opacity(0.9), // Transparent white
                    Color.clear               // Fully transparent
                ]),
                center: .bottomLeading,
                startRadius: 5,
                endRadius: 400
            )
            .blendMode(.overlay)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    GradientBackgroundView()
}
