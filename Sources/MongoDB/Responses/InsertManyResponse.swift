//
//  InsertManyResponse.swift
//
//
//  Created by Andrew Barba on 2/17/23.
//

import Compute

public struct InsertManyResponse: ActionResponse {
    public struct Result: Decodable {
        public let insertedIds: [String]
    }

    public let response: FetchResponse

    public func result() async throws -> Result {
        return try await response.decode(Result.self)
    }
}
