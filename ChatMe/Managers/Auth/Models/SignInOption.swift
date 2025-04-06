//
//  SignInOption.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 6. 4. 2025..
//

import Foundation

public enum SignInOption: Sendable {
    case apple, anonymous
    case google(GIDClientID: String)
    
    public var stringValue: String {
        switch self {
        case .apple:
            return "apple"
        case .anonymous:
            return "anonymous"
        case .google:
            return "google"
        }
    }
    
    var eventParameters: [String: Any] {
        ["sign_in_option": stringValue]
    }
}
