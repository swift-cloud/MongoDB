//
//  Actions.swift
//  
//
//  Created by Andrew Barba on 2/16/23.
//

import Compute

public protocol Action {

    associatedtype Body: ActionBody

    associatedtype Response: ActionResponse

    var type: ActionType { get }

    var body: Body { get }

    func response(_ response: FetchResponse) -> Response
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

public protocol ActionResponse {

    var response: FetchResponse { get }
}

extension ActionResponse {

    public func decode<T>(decoder: JSONDecoder = .init()) async throws -> T where T: Decodable & Sendable {
        return try await response.decode(decoder: decoder)
    }

    public func decode<T>(_ type: T.Type, decoder: JSONDecoder = .init()) async throws -> T where T: Decodable & Sendable {
        return try await response.decode(type, decoder: decoder)
    }

    public func json() async throws -> Any {
        return try await response.json()
    }

    public func jsonObject() async throws -> [String: Any] {
        return try await response.jsonObject()
    }

    public func jsonArray() async throws -> [Any] {
        return try await response.jsonArray()
    }

    public func formValues() async throws -> [String: String] {
        return try await response.formValues()
    }

    public func text() async throws -> String {
        return try await response.text()
    }

    public func data() async throws -> Data {
        return try await response.data()
    }

    public func bytes() async throws -> [UInt8] {
        return try await response.bytes()
    }
}
