//
//  AppError.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 10. 4. 2025..
//
import Foundation

struct AppError: LocalizedError {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    var errorDescription: String? {
        return message
    }
}
