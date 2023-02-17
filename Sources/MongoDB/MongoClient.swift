//
//  DataAPI.swift
//  
//
//  Created by Andrew Barba on 2/16/23.
//

import Compute

public struct MongoClient: Sendable {

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

    public func collection(_ name: String) -> Collection {
        return .init(name: name, client: self)
    }

    public func send<A: Action>(_ action: A, in collection: String) async throws -> A.Response {
        var body = action.body
        body.dataSource = cluster
        body.database = database
        body.collection = collection
        let res = try await fetch("\(endpoint)/action/\(action.type.rawValue)", .options(
            method: .post,
            body: .json(body),
            headers: [
                "accept": "application/json",
                "content-type": "application/json",
                "api-key": apiKey
            ]
        ))
        return action.response(res)
    }
}
