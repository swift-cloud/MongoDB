//
//  Types.swift
//  
//
//  Created by Andrew Barba on 2/16/23.
//

public enum SortDirection: Int, Encodable {
    case asc = 1
    case desc = -1
}

public typealias Sort = [String: SortDirection]

public typealias Limit = Int

public struct AllFilter: Encodable {
    public static let all = AllFilter()
}
