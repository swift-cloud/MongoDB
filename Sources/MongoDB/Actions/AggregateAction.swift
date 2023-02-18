//
//  AggregateAction.swift
//
//
//  Created by Andrew Barba on 2/16/23.
//

import Compute

public struct AggregateAction: Action {
    public struct Body: ActionBody {
        public var dataSource: String? = nil
        public var database: String? = nil
        public var collection: String? = nil
        public var pipeline: AggregatePipeline
    }

    public let type = ActionType.aggregate

    public let body: Body

    public init(pipeline: AggregatePipeline) {
        self.body = .init(pipeline: pipeline)
    }

    public func response(_ response: FetchResponse) -> DocumentsResponse {
        return DocumentsResponse(response: response)
    }
}

extension Action {
    public static func aggregate(pipeline: AggregatePipeline) -> Self where Self == AggregateAction {
        return .init(pipeline: pipeline)
    }
}

extension AggregatePipelineStep {

    public static func match(_ value: some Encodable) -> Self {
        return ["$match": .init(value)]
    }

    public static func group(id: some Encodable, fields: [String: AnyEncodable] = [:]) -> Self {
        let value = ["_id": id].merging(fields) { $1 }
        return ["$group": .init(value)]
    }

    public static func limit(_ value: Limit) -> Self {
        return ["$limit": .init(value)]
    }

    public static func skip(_ value: Skip) -> Self {
        return ["$skip": .init(value)]
    }

    public static func sort(_ value: Sort) -> Self {
        return ["$sort": .init(value)]
    }
}
