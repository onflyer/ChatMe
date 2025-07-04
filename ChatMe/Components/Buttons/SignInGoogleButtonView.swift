//
//  SignInWithGoogleButtonView.swift
//
//
//  Created by Nicholas Sarno on 11/6/23.
//

import Foundation
import SwiftUI
import AuthenticationServices

public extension Color {
    static let googleRedd = Color("GoogleRed")
}

public struct SignInGoogleButtonView: View {
    
    private var backgroundColor: Color
    private var foregroundColor: Color
    private var borderColor: Color
    private var buttonText: String
    private var cornerRadius: CGFloat
        
    public init(
        type: ASAuthorizationAppleIDButton.ButtonType = .signIn,
        style: ASAuthorizationAppleIDButton.Style = .black,
        cornerRadius: CGFloat = 10
    ) {
        self.cornerRadius = cornerRadius
        self.backgroundColor = style.backgroundColor
        self.foregroundColor = style.foregroundColor
        self.borderColor = style.borderColor
        self.buttonText = type.buttonText
    }
    
    public init(
        type: ASAuthorizationAppleIDButton.ButtonType = .signIn,
        backgroundColor: Color = .googleRedd,
        borderColor: Color = .white,
        foregroundColor: Color = .white,
        cornerRadius: CGFloat = 10
    ) {
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.foregroundColor = foregroundColor
        self.buttonText = type.buttonText
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(borderColor)
                
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(backgroundColor)
                .padding(0.8)
            
            HStack(spacing: 8) {
                Image("GoogleIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                
                Text("\(buttonText) Google")
                    .font(.system(size: 21, weight: .medium, design: .default))
                    
            }
            .foregroundColor(foregroundColor)
        }
        .padding(.vertical, 1)
        .disabled(true)
    }
}

#Preview("SignInWithGoogleButtonView") {
    ScrollView {
        VStack(spacing: 24) {
            SignInWithAppleButtonView(
                type: .signIn,
                style: .whiteOutline,
                cornerRadius: 10
            )
            .frame(height: 55)
            .frame(maxWidth: 400)
            .anyButton(.press) {
//                presenter.onSignInApplePressed(delegate: delegate)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            ForEach(ASAuthorizationAppleIDButton.ButtonType.allCases, id: \.rawValue) { type in
                SignInGoogleButtonView(type: type, backgroundColor: .white, foregroundColor: .primary)
                    .frame(height: 60)
            }
            Divider()

            ForEach(ASAuthorizationAppleIDButton.Style.allCases, id: \.rawValue) { style in
                ForEach(ASAuthorizationAppleIDButton.ButtonType.allCases, id: \.rawValue) { type in
                    SignInGoogleButtonView(type: type, style: style, cornerRadius: 10)
                        .frame(height: 60)
                }
                Divider()
            }
        }
        .padding()
    }
    .background(Color.gray.ignoresSafeArea())
}
