//
//  ChatMeApp.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 28. 3. 2025..
//

import SwiftUI

@main
struct ChatMeApp: App {
    
//    static func main() async {
//        let instance = GeminiAIService()
//        let chat = [AIChatModel(role: .user, content: "Hello how are you"),AIChatModel(role: .user, content: "Have you ever been in italy"), AIChatModel(role: .user, content: "whats the capital") ]
//        let response = try? await instance.generateText(chats: chat)
//        print(response!.message)
//    }
    
//    static func main() async {
//        let instance = GeminiAIService()
//        let chat = [AIChatModel(role: .user, content: "Hello how are you"),AIChatModel(role: .user, content: "Have you ever been in italy"), AIChatModel(role: .user, content: "Tell me more about it")]
//        
//        let stream = try? await instance.generateTextStream(chats: chat)
//        
//        do {
//            for try await value in stream.unsafelyUnwrapped {
//                print(value.message)
//            }
//        } catch {
//            print(error)
//        }
//    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            delegate.builder.appView()
        }
    }
}
