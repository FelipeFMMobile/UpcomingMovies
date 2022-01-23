//
//  GetParams.swift
//  UpcomingMoviesApi
//
//  Created by FMMobile on 19/05/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

public class QueryItensConvert {
    public func queryItens(url: URL, params: [String: Any]) -> URL {
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            var queryItems = [URLQueryItem]()
            params.forEach { key, value in
                guard value is Int || value is String || value is Double || value is Float || value is Character else {
                    debugPrint("Incorrect query string param")
                    return
                }
                queryItems.append(URLQueryItem(name: "\(key)", value: "\(value)"))
            }
            if queryItems.count > 0 { urlComponents.queryItems = queryItems }
            return urlComponents.url ?? url
        }
        return url
    }
}

/// GetParams Parse Build
public class GetParams: QueryItensConvert, ParamsProtocol {
    let params: [String: Any]

    public required init(params: [String: Any]) {
        self.params = params
    }

    public func buildParams(request: URLRequest) -> URLRequest {
        var orequest = request

        if var url = request.url {
            url = queryItens(url: url, params: params)
            orequest.url = url
        }
        return orequest
    }
}
