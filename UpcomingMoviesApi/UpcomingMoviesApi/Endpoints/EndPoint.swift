//
//  UpcomingEndpoints.swift
//  UpcomingMoviesApi
//
//  Created by FMMobile on 19/05/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

public typealias Header = [String: String]
public typealias Path = String

public protocol EndPoint {
    func path() -> Path
    func header() -> Header
    func contentType() -> ContentType
}
//
//public enum UpcomingEndpoints {
//    case upComing
//    case genres
//    case movie
//}
//
//extension UpcomingEndpoints: EndPoint {
//    public func path() -> Path {
//        switch self {
//        case .upComing:
//            return "movie/upcoming"
//        case .genres:
//            return "genre/movie/list"
//        case .movie:
//            return "movie/"
//        }
//    }
//    public func header() -> Header {
//        switch self {
//        default:
//            return [:]
//        }
//    }
//    
//    public func method() -> HttpMethod {
//        switch self {
//        default:
//            return .GET
//        }
//    }
//    
//    public func contentType() -> ContentType {
//        switch self {
//        default:
//            return .json
//        }
//    }
//}
