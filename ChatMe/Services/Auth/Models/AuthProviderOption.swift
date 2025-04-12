//
//  AuthProviderOption.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 6. 4. 2025..
//

import Foundation
import FirebaseAuth

enum AuthProviderOption: String, Codable, Sendable, CaseIterable {
    case google
    case apple
    case email
    case phone
    case facebook
    case gameCenter
    case github
    
    init?(providerId: String) {
        if let value = AuthProviderOption.allCases.first(where: { $0.providerIdString == providerId }) {
            self = value
        } else {
            return nil
        }
    }

    var providerIdString: String {
        switch self {
        case .google:       return "google.com"
        case .apple:        return "apple.com"
        case .email:        return "password"
        case .phone:        return "phone"
        case .facebook:     return "facebook.com"
        case .gameCenter:   return "gc.apple.com"
        case .github:       return "github.com"
        }
    }
    
    var providerId: AuthProviderID {
        switch self {
        case .google:
            return .google
        case .apple:
            return .apple
        case .email:
            return .email
        case .phone:
            return .phone
        case .facebook:
            return .facebook
        case .gameCenter:
            return .gameCenter
        case .github:
            return .gitHub
        }
    }

}


