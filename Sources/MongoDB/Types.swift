//
//  Types.swift
//  
//
//  Created by Andrew Barba on 2/16/23.
//

public typealias Field = String

public enum SortDirection: Int, Encodable {
    case asc = 1
    case desc = -1
}

public typealias Sort = [Field: SortDirection]

public typealias Limit = Int

public typealias Skip = Int

public enum ProjectionBehavior: Int, Encodable {
    case include = 1
    case exclude = 0
}

public typealias Projection = [Field: ProjectionBehavior]

public typealias AggregatePipelineStep = [String: AnyEncodable]

public typealias AggregatePipeline = [AggregatePipelineStep]

public struct AllFilter: Encodable {
    public static let all = AllFilter()
}
