//
//  FindAction.swift
//  
//
//  Created by Andrew Barba on 2/16/23.
//

public struct FindAction<Filter: Encodable>: Action {
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
}

extension Action {
    public static func find(
        sort: Sort? = nil,
        limit: Limit? = nil
    ) -> Self where Self == FindAction<AllFilter> {
        return .init(sort: sort, limit: limit)
    }

    public static func find<Filter: Encodable>(
        filter: Filter,
        sort: Sort? = nil,
        limit: Limit? = nil
    ) -> Self where Self == FindAction<Filter> {
        return .init(filter: filter, sort: sort, limit: limit)
    }
}
