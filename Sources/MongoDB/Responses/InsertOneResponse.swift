//
//  InsertOneResponse.swift
//  
//
//  Created by Andrew Barba on 2/17/23.
//

import Compute

public struct InsertOneResponse: ActionResponse {
    public struct Result: Decodable {
        public let insertedId: String
    }

    public let response: FetchResponse

    public func result() async throws -> Result {
        return try await response.decode(Result.self)
    }
}
