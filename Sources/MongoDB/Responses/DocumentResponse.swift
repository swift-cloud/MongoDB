//
//  DocumentResponse.swift
//  
//
//  Created by Andrew Barba on 2/17/23.
//

import Compute

public struct DocumentResponse: ActionResponse {
    public struct Result<T: Decodable>: Decodable {
        public let document: T?
    }

    public let response: FetchResponse

    public func result<T: Decodable>(_ type: T.Type) async throws -> Result<T> {
        return try await response.decode(Result.self)
    }

    public func document<T: Decodable>(_ type: T.Type) async throws -> T? {
        return try await result(type).document
    }
}
