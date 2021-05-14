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

open class ApiRest: ApiRunner, ApiRestGetProtocol, ApiRestPostProtocol {
    
    public override init() { super.init() }
    
    public init(usingCache: Bool = false) {
        super.init()
        if usingCache {
            setCachePolicy()
        }
    }
    
    /// GET
    public func get<T, E>(endPoint: E, params: [String: Any]?, _ model: T.Type,
                          completion: @escaping (Result<ResultRequest<T>, ApiError>) -> Void) where T: Decodable, E: EndPoint {
        
        header = endPoint.header()
        
        let body = GetParams(params: params ?? [:])
        self.run(method: .GET, endPoint.contentType(), endPoint: endPoint.path(),
                 params: body, completion: completion)
    }
    
    /// POST
    public func post<T, E>(endPoint: E, params: [String: Any]?, _ model: T.Type,
                           completion: @escaping (Result<ResultRequest<T>, ApiError>) -> Void) where T: Decodable, E: EndPoint {
        
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

extension ApiRest: ApiRestCacheProtocol {
    /// set cachePolicy using 
    func setCachePolicy() {
        let cacheDirectory = (NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] as String).appendingFormat("/\(Bundle.main.bundleIdentifier ?? "cache")/" )
        self.configuration.urlCache = URLCache(memoryCapacity: 4 * 1024 * 1024,
                                               diskCapacity: 1 * 1024 * 1024,
                                               diskPath: cacheDirectory)
        self.configuration.requestCachePolicy = .useProtocolCachePolicy
    }
}
