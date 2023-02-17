//
//  FindAction.swift
//  
//
//  Created by Andrew Barba on 2/16/23.
//

import Compute

public struct FindAction<Filter: Encodable>: Action {
    public struct Body: ActionBody {
        public var dataSource: String? = nil
        public var database: String? = nil
        public var collection: String? = nil
        public var filter: Filter
        public var projection: Projection? = nil
        public var sort: Sort? = nil
        public var limit: Limit? = nil
        public var skip: Skip? = nil
    }

    public let type = ActionType.find

    public let body: Body

    public init(
        filter: Filter,
        projection: Projection? = nil,
        sort: Sort? = nil,
        limit: Limit? = nil
    ) {
        self.body = .init(filter: filter, projection: projection, sort: sort, limit: limit)
    }

    public init(
        projection: Projection? = nil,
        sort: Sort? = nil,
        limit: Limit? = nil
    ) where Filter == AllFilter {
        self.body = .init(filter: .all, projection: projection, sort: sort, limit: limit)
    }

    public func response(_ response: FetchResponse) -> some ActionResponse {
        return DocumentsResponse(response: response)
    }
}

extension Action {
    public static func find(
        projection: Projection? = nil,
        sort: Sort? = nil,
        limit: Limit? = nil
    ) -> Self where Self == FindAction<AllFilter> {
        return .init(projection: projection, sort: sort, limit: limit)
    }

    public static func find<Filter: Encodable>(
        filter: Filter,
        projection: Projection? = nil,
        sort: Sort? = nil,
        limit: Limit? = nil
    ) -> Self where Self == FindAction<Filter> {
        return .init(filter: filter, projection: projection, sort: sort, limit: limit)
    }
}
