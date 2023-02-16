//
//  UpdateManyAction.swift
//
//
//  Created by Andrew Barba on 2/16/23.
//

public struct UpdateManyAction<Filter: Encodable, Update: Encodable>: Action {
    public struct Body: ActionBody {
        public var dataSource: String? = nil
        public var database: String? = nil
        public var collection: String? = nil
        public var filter: Filter
        public var update: Update
        public var upsert: Bool
    }

    public let type = ActionType.updateMany

    public let body: Body

    public init(
        update: Update,
        upsert: Bool = false
    ) where Filter == AllFilter {
        self.body = .init(filter: .all, update: update, upsert: upsert)
    }

    public init(
        filter: Filter,
        update: Update,
        upsert: Bool = false
    ) {
        self.body = .init(filter: filter, update: update, upsert: upsert)
    }
}

extension Action {
    public static func updateMany<Update: Encodable>(
        update: Update,
        upsert: Bool = false
    ) -> Self where Self == UpdateManyAction<AllFilter, Update> {
        return .init(update: update, upsert: upsert)
    }

    public static func updateMany<Filter: Encodable, Update: Encodable>(
        filter: Filter,
        update: Update,
        upsert: Bool = false
    ) -> Self where Self == UpdateManyAction<Filter, Update> {
        return .init(filter: filter, update: update, upsert: upsert)
    }
}
