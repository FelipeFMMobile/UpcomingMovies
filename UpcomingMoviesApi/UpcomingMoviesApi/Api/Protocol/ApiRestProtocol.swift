//
//  ApiProtocol.swift
//  UpcomingMoviesApi
//
//  Created by FMMobile on 19/05/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//
//  SOLID: Liskov Substitution Principle, Fat Interface Principle
//

import Foundation

public struct ResultRequest<T> {
    public var data: T
    public var request: URLRequest
}

public typealias CompletionRequest<T> = (Result<ResultRequest<T>, NSError>) -> Void

protocol ApiRestGetProtocol {
    func get<T: Decodable, E: EndPoint>(endPoint: E, params: [String: Any]?,
                                        _ model: T.Type, completion: @escaping CompletionRequest<T>)
}

protocol ApiRestPostProtocol {
    func post<T: Decodable, E: EndPoint>(endPoint: E, params: [String: Any]?,
                                         _ model: T.Type, completion: @escaping CompletionRequest<T>)
}

protocol ApiRestCacheProtocol {
    func setCachePolicy()
}

protocol ApiRestProtocol {
    
    func run<T: Decodable>(method: HttpMethod,
                           _ contentType: ContentType,
                           endPoint: String,
                           params: ParamsProtocol,
                           completion: @escaping CompletionRequest<T>
    )
    
    func addHeaderValue(value: String, key: String) -> Bool
    func setAuthorization(value: String) -> Bool
    func clearHeaderValues() -> Bool
}
