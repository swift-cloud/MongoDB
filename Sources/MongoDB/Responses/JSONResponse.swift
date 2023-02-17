//
//  JSONResponse.swift
//  
//
//  Created by Andrew Barba on 2/17/23.
//

import Compute

public struct JSONResponse: ActionResponse {

    public let response: FetchResponse

    public func result() async throws -> Any {
        return try await response.json()
    }
}
