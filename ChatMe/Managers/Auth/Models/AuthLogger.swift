//
//  AuthLogger.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 6. 4. 2025..
//

@MainActor
protocol AuthLogger {
    func identifyUser(userId: String, name: String?, email: String?)
    func trackEvent(event: AuthLogEvent)
    func addUserProperties(dict: [String: Any], isHighPriority: Bool)
}

protocol AuthLogEvent {
    var eventName: String { get }
    var parameters: [String: Any]? { get }
    var type: AuthLogType { get }
}

enum AuthLogType: Int, CaseIterable, Sendable {
    case info // 0
    case analytic // 1
    case warning // 2
    case severe // 3

    var emoji: String {
        switch self {
        case .info:
            return "👋"
        case .analytic:
            return "📈"
        case .warning:
            return "⚠️"
        case .severe:
            return "🚨"
        }
    }

    var asString: String {
        switch self {
        case .info: return "info"
        case .analytic: return "analytic"
        case .warning: return "warning"
        case .severe: return "severe"
        }
    }
}
