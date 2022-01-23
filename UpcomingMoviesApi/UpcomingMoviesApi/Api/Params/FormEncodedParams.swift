//
//  GetParams.swift
//  UpcomingMoviesApi
//
//  Created by FMMobile on 19/05/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

/// FormEncodedParams Parse Build
public class FormEncodedParams: QueryItensConvert, ParamsProtocol {
    let params: [String: Any]

    public required init(params: [String: Any]) {
        self.params = params
    }

    public func buildParams(request: URLRequest) -> URLRequest {
        var bodyComponents = URLComponents()
        bodyComponents.queryItems = []
        for (key, value) in params {
            let stringValue = value as? String ?? ""
            bodyComponents.queryItems?.append(URLQueryItem(name: key, value: stringValue))
        }
        var orequest = request
        orequest.httpBody = bodyComponents.query?.data(using: .utf8)
        return orequest
    }
}
