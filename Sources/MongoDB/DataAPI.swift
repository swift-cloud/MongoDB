//
//  DataAPI.swift
//  
//
//  Created by Andrew Barba on 2/16/23.
//

import Compute

public struct DataAPIClient: Sendable {

    public let endpoint: String

    public let cluster: String

    public let database: String

    private let apiKey: String

    public init(endpoint: String, cluster: String, database: String, apiKey: String) {
        self.endpoint = endpoint
        self.cluster = cluster
        self.database = database
        self.apiKey = apiKey
    }

    public func send(_ action: some Action, in collection: String) async throws -> FetchResponse {
        var body = action.body
        body.dataSource = cluster
        body.database = database
        body.collection = collection
        return try await fetch("\(endpoint)/action/\(action.type.rawValue)", .options(
            method: .post,
            body: .json(body),
            headers: [
                "accept": "application/json",
                "content-type": "application/json",
                "api-key": apiKey
            ]
        ))
    }
}
