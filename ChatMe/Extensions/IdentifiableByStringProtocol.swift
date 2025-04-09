//
//  IdentifiableByStringProtocol.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 9. 4. 2025..
//

import Foundation

public protocol StringIdentifiable: Identifiable {
    var id: String { get }
}
