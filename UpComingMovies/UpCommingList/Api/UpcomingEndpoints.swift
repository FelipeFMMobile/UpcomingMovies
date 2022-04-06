//
//  UpcomingEndpoints.swift
//  UpComingMovies
//
//  Created by FelipeMenezes on 04/05/20.
//  Copyright © 2020 FMMobile. All rights reserved.
//

import UpcomingMoviesApi

public enum UpcomingEndpoints {
    case upComing
    case genres
    case movie(String)
}

extension UpcomingEndpoints: EndPoint {
    public func path() -> Path {
        switch self {
        case .upComing:
            return "movie/upcoming"
        case .genres:
            return "genre/movie/list"
        case .movie(let idM):
            return "movie/\(idM)"
        }
    }
    public func header() -> Header {
        switch self {
        default:
            return [:]
        }
    }

    public func method() -> HttpMethod {
        switch self {
        default:
            return .GET
        }
    }

    public func contentType() -> ContentType {
        switch self {
        default:
            return .json
        }
    }
}
