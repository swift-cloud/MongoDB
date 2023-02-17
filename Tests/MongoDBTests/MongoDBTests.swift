import XCTest
@testable import MongoDB

let client = DataAPIClient(
    endpoint: "https://us-east-1.aws.data.mongodb-api.com/app/data-xqtwh/endpoint/data/v1",
    cluster: "one-bite-dev",
    database: "development",
    apiKey: "....."
)

final class MongoDBTests: XCTestCase {

    func testFindOne() async throws {
        let user = try await client.send(.findOne(), in: "users")
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
