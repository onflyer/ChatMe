//
//  AsyncSequence + EXT.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 27. 5. 2025..
//

import Foundation

extension AsyncSequence {
    
    @discardableResult
    func mapAsyncThrowingStream<Input, Output>(
        _ inputStream: AsyncThrowingStream<Input, Error>,
        transform: @escaping (Input) async throws -> Output
    ) -> AsyncThrowingStream<Output, Error> {
        return AsyncThrowingStream<Output, Error> { continuation in
            Task {
                do {
                    for try await value in inputStream {
                        let transformed = try await transform(value)
                        continuation.yield(transformed)
                    }
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
}
