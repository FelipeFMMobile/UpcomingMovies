//
//  Api.swift
//  UpcomingMoviesApi
//
//  Created by FMMobile on 19/05/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//
// SOLID: Liskov Substitution Principle, Fat Interface Principle
//

import Foundation

enum DefaultErrorCodes: Int {
    case domainFail = 999, responseCodableFail = 997, noDataResponse = 996, statusCodeError = 995
}

open class ApiRest: ApiRunner {
    
    public override init() { super.init() }
    
    /// GET
    public func get<T>(endPoint: EndPoint, params: [String: Any]?,
                       completion: @escaping (Result<ResultRequest<T>, Error>) -> Void) where T: Decodable {
        
        header = endPoint.header()
        
        let body = GetParams(params: params ?? [:])
        self.run(method: .GET, endPoint.contentType(), endPoint: endPoint.path(),
                 params: body, completion: completion)
    }
    
    /// POST
    public func post<T>(endPoint: EndPoint, params: [String: Any]?,
                       completion: @escaping (Result<ResultRequest<T>, Error>) -> Void) where T: Decodable {
        
        header = endPoint.header()
        var body: ParamsProtocol!
        switch endPoint.contentType() {
        case .json:
            body = JsonBodyParams(params: params ?? [:])
        case .formurlencoded:
            body = FormEncodedParams(params: params ?? [:])
        }
        
        self.run(method: .POST, endPoint.contentType(), endPoint: endPoint.path(),
                 params: body, completion: completion)
    }
}
