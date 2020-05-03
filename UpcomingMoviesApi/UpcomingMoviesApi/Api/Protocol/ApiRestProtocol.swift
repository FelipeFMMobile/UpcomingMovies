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
    var result: T
    var request: URLRequest
}

typealias CompletionRequest<T> = (Result<ResultRequest<T>, Error>) -> Void

protocol ApiRestGetProtocol {
    func get<T: Decodable>(endPoint: EndPoint, params: [String: Any]?,
                           completion: @escaping CompletionRequest<T>)
}

protocol ApiRestPostJsonProtocol {
    func post<T: Decodable>(endPoint: EndPoint, params: [String: Any]?,
                            completion: @escaping CompletionRequest<T>)
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
