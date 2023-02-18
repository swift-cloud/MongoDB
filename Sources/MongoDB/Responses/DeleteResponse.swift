//
//  DeleteResponse.swift
//  
//
//  Created by Andrew Barba on 2/17/23.
//

import Compute

public struct DeleteResponse: ActionResponse {
    public struct Result: Decodable {
        public let deletedCount: Int
    }

    public let response: FetchResponse

    public func result() async throws -> Result {
        return try await response.decode(Result.self)
    }

    public func count() async throws -> Int {
        return try await result().deletedCount
    }
}
