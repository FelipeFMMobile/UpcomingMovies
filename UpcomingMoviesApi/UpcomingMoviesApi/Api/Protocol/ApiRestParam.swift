//
//  ApiRestParam.swift
//  UpcomingMoviesApi
//
//  Created by Felipe Menezes on 19/01/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

protocol ApiRestParamProtocol: AnyObject {
    var domain: WebDomain { get }
    var method: HttpMethod { get }
    var contentType: ContentType { get }
    var endPoint: String { get }
    var params: ParamsProtocol { get }
    var header: ApiHeader { get }
    func generateDefaultHeader()
}

extension ApiRestParamProtocol {
    func generateDefaultHeader() {
        header.addHeaderValue(value: "Content-Type", key: contentType.contentType())
        header.addHeaderValue(value: "Accept", key: contentType.contentType())
        header.addHeaderValue(value: "x-fabricante", key: "Apple")
        header.addHeaderValue(value: "x-modelo", key: UIDevice.current.model)
        header.addHeaderValue(value: "x-sistema-operacional", key: UIDevice.current.systemVersion)
    }
}

class ApiRestParam: ApiRestParamProtocol {
    var domain: WebDomain = .domainForBundle()
    var method: HttpMethod = .GET
    var contentType: ContentType = .json
    var endPoint: String
    var params: ParamsProtocol
    var header: ApiHeader = ApiHeaderSimple()
    init(endPoint: String, params: ParamsProtocol) {
        self.endPoint =  domain.rawValue + endPoint
        self.params = params
    }
}
