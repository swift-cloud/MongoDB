import XCTest
@testable import MongoDB

let client = MongoClient(
    endpoint: "https://us-east-1.aws.data.mongodb-api.com/app/data-dpjph/endpoint/data/v1",
    cluster: "swift-cloud",
    database: "development",
    apiKey: ProcessInfo.processInfo.environment["MONGODB_API_KEY"]!
)

let collection = client.collection("xcode")

struct User: Codable {
    let _id: String
    let name: String
    let age: Int
}

final class MongoDBTests: XCTestCase {

    func testFindOneNil() async throws {
        let res = try await collection
            .send(.findOne(filter: ["name": "andrew"]))
            .result(User.self)
        XCTAssertNil(res.document)
    }

    func testFindManyEmpty() async throws {
        let res = try await collection
            .send(.find(filter: ["name": "andrew"]))
            .result(User.self)
        XCTAssertEqual(res.documents.count, 0)
    }

    func testDeleteOneEmpty() async throws {
        let res = try await collection
            .send(.deleteOne(filter: ["name": "andrew"]))
            .result()
        XCTAssertEqual(res.deletedCount, 0)
    }

    func testDeleteManyEmpty() async throws {
        let res = try await collection
            .send(.deleteMany(filter: ["name": "andrew"]))
            .result()
        XCTAssertEqual(res.deletedCount, 0)
    }
}
