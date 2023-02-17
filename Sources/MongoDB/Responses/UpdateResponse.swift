//
//  UpdateResponse.swift
//
//
//  Created by Andrew Barba on 2/17/23.
//

import Compute

public struct UpdateResponse: ActionResponse {
    public struct Result: Decodable {
        public let matchedCount: Int
        public let modifiedCount: Int
        public let upsertedId: String?
    }

    public let response: FetchResponse

    public func result() async throws -> Result {
        return try await response.decode(Result.self)
    }
}
