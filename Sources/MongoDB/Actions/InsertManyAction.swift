//
//  InsertManyAction.swift
//  
//
//  Created by Andrew Barba on 2/16/23.
//

public struct InsertManyAction<Document: Encodable>: Action {
    public struct Body: ActionBody {
        public var dataSource: String? = nil
        public var database: String? = nil
        public var collection: String? = nil
        public var documents: [Document]
    }

    public let type = ActionType.insertMany

    public let body: Body

    public init(
        documents: [Document]
    ) {
        self.body = .init(documents: documents)
    }
}

extension Action {
    public static func insertMany<T: Encodable>(
        documents: [T]
    ) -> Self where Self == InsertManyAction<T> {
        return .init(documents: documents)
    }
}
