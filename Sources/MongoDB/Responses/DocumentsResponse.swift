//
//  DocumentsResponse.swift
//  
//
//  Created by Andrew Barba on 2/17/23.
//

import Compute

public struct DocumentsResponse: ActionResponse {
    public struct Result<T: Decodable>: Decodable {
        public let documents: [T]
    }

    public let response: FetchResponse

    public func result<T: Decodable>(_ type: T.Type) async throws -> Result<T> {
        return try await response.decode(Result.self)
    }

    public func documents<T: Decodable>(_ type: T.Type) async throws -> [T] {
        return try await result(type).documents
    }
}
