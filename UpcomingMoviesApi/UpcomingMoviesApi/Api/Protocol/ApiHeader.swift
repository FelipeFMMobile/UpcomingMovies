//
//  ApiHeader.swift
//  UpcomingMoviesApi
//
//  Created by Felipe Menezes on 19/01/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

import Foundation

protocol ApiHeader {
    var header: [String: String] { get set }
    func addHeaderValue(value: String, key: String)
    func setAuthorization(value: String)
    func clearHeaderValues()
}

class ApiHeaderSimple: ApiHeader {
    var header: [String: String] = [:]
    func addHeaderValue(value: String, key: String) {
        self.header[key] = value
    }

    func clearHeaderValues() {
        self.header.removeAll()
    }

    func setAuthorization(value: String) {
        addHeaderValue(value: value, key: "Authorization")
    }
}
