//
//  View+EXT.swift
//  AIChatCourse
//
//  Created by Aleksandar Milidrag on 10/6/24.
//

import SwiftUI

extension View {
    
    func callToActionButton(forgroundStyle: Color = .primary, background: Color = .accentColor, cornerRadius: CGFloat = 16) -> some View {
        self
            .font(.system(size: 18, weight: .regular, design: .default))
            .frame(height: 55)
            .foregroundStyle(forgroundStyle)
            .frame(maxWidth: .infinity)
            .background(background)
            .cornerRadius(cornerRadius)
    }
    
    func badgeButton() -> some View {
        self
            .font(.caption)
            .bold()
            .foregroundStyle(Color.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(Color.blue)
            .cornerRadius(10)
    }
    
    func tappableBackground() -> some View {
        background(Color.black.opacity(0.001))
    }
    
    func removeListRowFormatting() -> some View {
        self
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowBackground(Color.clear)
    }
    
    func addingGradientBackgroundForText() -> some View {
        background(
            LinearGradient(colors: [
                Color.black.opacity(0),
                Color.black.opacity(0.3),
                Color.black.opacity(0.4)
            ], startPoint: .top, endPoint: .bottom)
        )
    }
    
    @ViewBuilder
    func ifSatisfiedCondition(_ condition: Bool, transform: (Self) -> some View) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

}

extension View {
    func any() -> AnyView {
        AnyView(self)
    }
}
