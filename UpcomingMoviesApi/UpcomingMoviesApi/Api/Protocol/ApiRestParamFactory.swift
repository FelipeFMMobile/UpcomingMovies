//
//  ApiRestParamFactory.swift
//  UpcomingMoviesApi
//
//  Created by Felipe Menezes on 21/01/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

protocol ApiRestParamFactoryProtocol {
    func generate(endPoint: String, params: ParamsProtocol) -> ApiRestParamProtocol
    func generate(method: HttpMethod, endPoint: String, params: ParamsProtocol) -> ApiRestParamProtocol
}

extension ApiRestParamFactoryProtocol {
    func generate(endPoint: String, params: ParamsProtocol) -> ApiRestParamProtocol {
        ApiRestParam(endPoint: endPoint, params: params)
    }

    func generate(method: HttpMethod, endPoint: String, params: ParamsProtocol) -> ApiRestParamProtocol {
        let param = ApiRestParam(endPoint: endPoint, params: params)
        param.method = method
        return param
    }
}

enum ApiParamFactory: ApiRestParamFactoryProtocol {
    case basic
}
