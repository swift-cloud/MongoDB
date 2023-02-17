//
//  DeleteManyAction.swift
//
//
//  Created by Andrew Barba on 2/16/23.
//

import Compute

public struct DeleteManyAction<Filter: Encodable>: Action {
    public struct Body: ActionBody {
        public var dataSource: String? = nil
        public var database: String? = nil
        public var collection: String? = nil
        public var filter: Filter
        public var sort: Sort? = nil
        public var limit: Limit? = nil
    }

    public let type = ActionType.find

    public let body: Body

    public init(
        filter: Filter,
        sort: Sort? = nil,
        limit: Limit? = nil
    ) {
        self.body = .init(filter: filter, sort: sort, limit: limit)
    }

    public init(
        sort: Sort? = nil,
        limit: Limit? = nil
    ) where Filter == AllFilter {
        self.body = .init(filter: .all, sort: sort, limit: limit)
    }

    public func response(_ response: FetchResponse) -> some ActionResponse {
        return DeleteResponse(response: response)
    }
}

extension Action {
    public static func deleteMany(
        sort: Sort? = nil,
        limit: Limit? = nil
    ) -> Self where Self == DeleteManyAction<AllFilter> {
        return .init(sort: sort, limit: limit)
    }

    public static func deleteMany<Filter: Encodable>(
        filter: Filter,
        sort: Sort? = nil,
        limit: Limit? = nil
    ) -> Self where Self == DeleteManyAction<Filter> {
        return .init(filter: filter, sort: sort, limit: limit)
    }
}
