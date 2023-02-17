import XCTest
@testable import MongoDB

let client = MongoClient(
    endpoint: "https://us-east-1.aws.data.mongodb-api.com/app/data-trlzv/endpoint/data/v1",
    cluster: "swift-cloud",
    database: "development",
    apiKey: ProcessInfo.processInfo.environment["MONGODB_API_KEY"]!
)

final class MongoDBTests: XCTestCase {

    func testFindOne() async throws {
        let user = try await client.collection("users").send(.findOne())
        print(user)
    }

    func testFindMany() async throws {
        let action = FindAction(filter: ["name": "Andrew"])
        let users = try await client.send(action, in: "users").json()
        print(users)
    }

    func testCollection() async throws {
        let users = try await client.collection("users").send(.findOne())
        print(users)
    }
}
