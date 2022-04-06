//
//  ApiHeader.swift
//  UpcomingMoviesApi
//
//  Created by Felipe Menezes on 19/01/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

import Foundation

public protocol ApiHeader {
    var header: [String: String] { get set }
    func addHeaderValue(value: String, key: String)
    func setAuthorization(value: String)
    func clearHeaderValues()
}

public class ApiHeaderSimple: ApiHeader {
    public var header: [String: String] = [:]
    public func addHeaderValue(value: String, key: String) {
        self.header[key] = value
    }

    public func clearHeaderValues() {
        self.header.removeAll()
    }

    public func setAuthorization(value: String) {
        addHeaderValue(value: value, key: "Authorization")
    }
}
