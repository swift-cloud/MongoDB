//
//  FindOneAction.swift
//  
//
//  Created by Andrew Barba on 2/16/23.
//

import Compute

public struct FindOneAction<Filter: Encodable>: Action {
    public struct Body: ActionBody {
        public var dataSource: String? = nil
        public var database: String? = nil
        public var collection: String? = nil
        public var filter: Filter
        public var projection: Projection? = nil
    }

    public let type = ActionType.findOne

    public let body: Body

    public init(
        filter: Filter,
        projection: Projection? = nil
    ) {
        self.body = .init(filter: filter, projection: projection)
    }

    public init(
        projection: Projection? = nil
    ) where Filter == AllFilter {
        self.body = .init(filter: .all, projection: projection)
    }

    public func response(_ response: FetchResponse) -> some ActionResponse {
        return DocumentResponse(response: response)
    }
}

extension Action {
    public static func findOne(
        projection: Projection? = nil
    ) -> Self where Self == FindOneAction<AllFilter> {
        return .init(projection: projection)
    }

    public static func findOne<Filter: Encodable>(
        filter: Filter,
        projection: Projection? = nil
    ) -> Self where Self == FindOneAction<Filter> {
        return .init(filter: filter, projection: projection)
    }
}
