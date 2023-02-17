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

    init(name: String, age: Int) {
        self._id = UUID().uuidString.lowercased()
        self.name = name
        self.age = age
    }
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

    func testUpdateOneEmpty() async throws {
        let res = try await collection
            .send(.updateOne(filter: ["name": "andrew"], update: ["a": 1]))
            .result()
        XCTAssertEqual(res.matchedCount, 0)
        XCTAssertEqual(res.modifiedCount, 0)
        XCTAssertNil(res.upsertedId)
    }

    func testUpdateManyEmpty() async throws {
        let res = try await collection
            .send(.updateMany(filter: ["name": "andrew"], update: ["a": 1]))
            .result()
        XCTAssertEqual(res.matchedCount, 0)
        XCTAssertEqual(res.modifiedCount, 0)
        XCTAssertNil(res.upsertedId)
    }

    func testReplaceOneEmpty() async throws {
        let res = try await collection
            .send(.replaceOne(filter: ["name": "andrew"], replacement: ["a": 1]))
            .result()
        XCTAssertEqual(res.matchedCount, 0)
        XCTAssertEqual(res.modifiedCount, 0)
        XCTAssertNil(res.upsertedId)
    }

    func testInsertOne() async throws {
        let doc = User(name: UUID().uuidString, age: .random(in: 10...100))
        let res = try await collection
            .send(.insertOne(document: doc))
            .result()
        XCTAssertEqual(doc._id, res.insertedId)
    }

    func testInsertMany() async throws {
        let docs = Array(1...10).map { _ in
            User(name: UUID().uuidString, age: .random(in: 10...100))
        }
        let res = try await collection
            .send(.insertMany(documents: docs))
            .result()
        XCTAssertEqual(docs.count, res.insertedIds.count)
    }
}
