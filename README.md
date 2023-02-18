# MongoDB

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fswift-cloud%2FMongoDB%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/swift-cloud/MongoDB)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fswift-cloud%2FMongoDB%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/swift-cloud/MongoDB)

A [MongoDB Atlas](https://www.mongodb.com/atlas) Data API library compatible with all Apple platforms, Swift Cloud and Fastly Compute@Edge

## Usage

```swift
import MongoDB

let client = MongoClient(
    endpoint: "https://us-east-1.aws.data.mongodb-api.com/app/data-12345/endpoint/data/v1",
    cluster: "cluster-prod",
    database: "test",
    apiKey: "..."
)

let user = try await client
    .collection("users")
    .send(.findOne())
    .document(User.self)
```
