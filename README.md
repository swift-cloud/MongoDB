# MongoDB

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
