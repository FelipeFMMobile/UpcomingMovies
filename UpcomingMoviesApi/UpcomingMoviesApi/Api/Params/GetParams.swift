//
//  GetParams.swift
//  UpcomingMoviesApi
//
//  Created by FMMobile on 19/05/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

class QueryItensConvert {
    func queryItens(url: URL, params: [String: Any]) -> URL {
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            var queryItems = [URLQueryItem]()
            params.forEach { key, value in
<<<<<<< HEAD
                if ((value as? Int) != nil) || ((value as? String) != nil) || ((value as? Double) != nil)
                    || ((value as? Float) != nil) || ((value as? Character) != nil) {
                    queryItems.append(URLQueryItem(name: "\(key)", value: "\(value)"))
                }
=======
                guard value is Int || value is String || value is Double || value is Float || value is Character else {
                    debugPrint("Incorrect query string param")
                    return
                }
                queryItems.append(URLQueryItem(name: "\(key)", value: "\(value)"))
>>>>>>> revision2022
            }
            if queryItems.count > 0 { urlComponents.queryItems = queryItems }
            return urlComponents.url ?? url
        }
        return url
    }
}

/// GetParams Parse Build
class GetParams: QueryItensConvert, ParamsProtocol {
    let params: [String: Any]
<<<<<<< HEAD
    
    required init(params: [String: Any]) {
        self.params = params
    }
    
    func buildParams(request: URLRequest) -> URLRequest {
        var orequest = request
        
=======

    required init(params: [String: Any]) {
        self.params = params
    }

    func buildParams(request: URLRequest) -> URLRequest {
        var orequest = request

>>>>>>> revision2022
        if var url = request.url {
            url = queryItens(url: url, params: params)
            orequest.url = url
        }
        return orequest
    }
}
