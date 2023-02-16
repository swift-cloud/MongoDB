//
//  FindOneAction.swift
//  
//
//  Created by Andrew Barba on 2/16/23.
//

public struct FindOneAction<Filter: Encodable>: Action {
    public struct Body: ActionBody {
        public var dataSource: String? = nil
        public var database: String? = nil
        public var collection: String? = nil
        public var filter: Filter
    }

    public let type = ActionType.findOne

    public let body: Body

    public init(filter: Filter) {
        self.body = .init(filter: filter)
    }

    public init() where Filter == AllFilter {
        self.body = .init(filter: .all)
    }
}

extension Action {
    public static func findOne() -> Self where Self == FindOneAction<AllFilter> {
        return .init()
    }

    public static func findOne<Filter: Encodable>(
        filter: Filter
    ) -> Self where Self == FindOneAction<Filter> {
        return .init(filter: filter)
    }
}
