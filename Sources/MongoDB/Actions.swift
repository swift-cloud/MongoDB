//
//  Actions.swift
//  
//
//  Created by Andrew Barba on 2/16/23.
//

public protocol Action {
    var type: ActionType { get }

    associatedtype Body: ActionBody
    var body: Body { get }
}

public enum ActionType: String {
    case find
    case findOne
    case insertOne
    case insertMany
    case updateOne
    case updateMany
    case replaceOne
    case deleteOne
    case deleteMany
    case aggregate
}

public protocol ActionBody: Encodable {
    var dataSource: String? { get set }
    var database: String? { get set }
    var collection: String? { get set }
}
