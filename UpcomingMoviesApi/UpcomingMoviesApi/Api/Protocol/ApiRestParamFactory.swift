//
//  ApiRestParamFactory.swift
//  UpcomingMoviesApi
//
//  Created by Felipe Menezes on 21/01/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

public protocol ApiRestParamFactoryProtocol {
    func generate(endPoint: String, params: ParamsProtocol) -> ApiRestParamProtocol
    func generate(method: HttpMethod, endPoint: String, params: ParamsProtocol) -> ApiRestParamProtocol
}

extension ApiRestParamFactoryProtocol {
    public func generate(endPoint: String, params: ParamsProtocol) -> ApiRestParamProtocol {
        ApiRestParam(endPoint: endPoint, params: params)
    }

    public func generate(method: HttpMethod, endPoint: String, params: ParamsProtocol) -> ApiRestParamProtocol {
        let param = ApiRestParam(endPoint: endPoint, params: params)
        param.method = method
        return param
    }
}

public enum ApiParamFactory: ApiRestParamFactoryProtocol {
    case basic
}
