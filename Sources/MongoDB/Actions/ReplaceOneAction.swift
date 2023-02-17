//
//  ReplaceOneAction.swift
//
//
//  Created by Andrew Barba on 2/16/23.
//

import Compute

public struct ReplaceOneAction<Filter: Encodable, Replacement: Encodable>: Action {
    public struct Body: ActionBody {
        public var dataSource: String? = nil
        public var database: String? = nil
        public var collection: String? = nil
        public var filter: Filter
        public var replacement: Replacement
        public var upsert: Bool
    }

    public let type: ActionType = .replaceOne

    public let body: Body

    public init(
        replacement: Replacement,
        upsert: Bool = false
    ) where Filter == AllFilter {
        self.body = .init(filter: .all, replacement: replacement, upsert: upsert)
    }

    public init(
        filter: Filter,
        replacement: Replacement,
        upsert: Bool = false
    ) {
        self.body = .init(filter: filter, replacement: replacement, upsert: upsert)
    }

    public func response(_ response: FetchResponse) -> UpdateResponse {
        return UpdateResponse(response: response)
    }
}

extension Action {
    public static func replaceOne<Replacement: Encodable>(
        replacement: Replacement,
        upsert: Bool = false
    ) -> Self where Self == ReplaceOneAction<AllFilter, Replacement> {
        return .init(replacement: replacement, upsert: upsert)
    }

    public static func replaceOne<Filter: Encodable, Replacement: Encodable>(
        filter: Filter,
        replacement: Replacement,
        upsert: Bool = false
    ) -> Self where Self == ReplaceOneAction<Filter, Replacement> {
        return .init(filter: filter, replacement: replacement, upsert: upsert)
    }
}
