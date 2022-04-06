//
//  JsonBodyParams.swift
//  UpcomingMoviesApi
//
//  Created by FMMobile on 19/05/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import Foundation

/// JsonBodyParams Parse Build
public class JsonBodyParams: ParamsProtocol {
    let params: [String: Any]
    public required init(params: [String: Any]) {
        self.params = params
    }

    public func buildParams(request: URLRequest) -> URLRequest {
        var orequest = request
        if JSONSerialization.isValidJSONObject(params) {
            do {
                let data = try JSONSerialization.data(withJSONObject: params, options: [])
                orequest.httpBody = data
            } catch { }
        }
        return orequest
    }
}
