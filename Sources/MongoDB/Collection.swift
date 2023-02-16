//
//  Collection.swift
//  
//
//  Created by Andrew Barba on 2/16/23.
//

import Compute

public struct Collection {

    public let name: String

    internal let client: DataAPIClient

    public func send(_ action: some Action) async throws -> FetchResponse {
        return try await client.send(action, in: name)
    }
}
