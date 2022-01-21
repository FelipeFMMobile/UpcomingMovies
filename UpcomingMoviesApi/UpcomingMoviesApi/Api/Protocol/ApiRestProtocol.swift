//
//  ApiProtocol.swift
//  UpcomingMoviesApi
//
//  Created by FMMobile on 19/05/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//
//  SOLID: Liskov Substitution Principle, Fat Interface Principle
//

public typealias ApiCompletionRequest<T> = (_ result: Result<T, NSError>,
                                            _ request: URLRequest?) -> Void
protocol ApiRestProtocol {
    func run<T: Decodable>(param: ApiRestParamProtocol,
                           _ resultModel: T.Type,
                           completion: @escaping ApiCompletionRequest<T>
    )
}
