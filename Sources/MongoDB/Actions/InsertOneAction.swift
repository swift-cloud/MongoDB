//
//  InsertOneAction.swift
//  
//
//  Created by Andrew Barba on 2/16/23.
//

public struct InsertOneAction<Document: Encodable>: Action {
    public struct Body: ActionBody {
        public var dataSource: String? = nil
        public var database: String? = nil
        public var collection: String? = nil
        public var document: Document
    }

    public let type = ActionType.insertMany

    public let body: Body

    public init(
        document: Document
    ) {
        self.body = .init(document: document)
    }
}

extension Action {
    public static func insertOne<T: Encodable>(
        document: T
    ) -> Self where Self == InsertOneAction<T> {
        return .init(document: document)
    }
}
