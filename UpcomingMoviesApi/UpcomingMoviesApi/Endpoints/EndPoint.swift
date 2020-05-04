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
