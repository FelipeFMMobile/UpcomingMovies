//
//  ApiProtocol.swift
//  UpcomingMoviesApi
//
//  Created by FMMobile on 19/05/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//
//  SOLID: Liskov Substitution Principle, Fat Interface Principle
//

public enum ApiError: Error, Equatable {
    case domainFail, contentSerializeError(Error?), networkingError(NSError), statusCodeError(Int)

    public static func == (lhs: ApiError, rhs: ApiError) -> Bool {
        switch (lhs, rhs) {
        case (.domainFail, .domainFail):
            return true
        case (.contentSerializeError, .contentSerializeError):
            return true
        case (.networkingError(let lError), networkingError(let rError)):
            return lError.code == rError.code
        case (.statusCodeError(let lCode), statusCodeError(let rCode)):
            return lCode == rCode
        default:
            return false
        }
    }
}

public typealias ApiCompletionRequest<T> = (_ result: Result<T, NSError>,
                                            _ request: URLRequest?) -> Void
protocol ApiRestProtocol {
    func run<T: Decodable>(param: ApiRestParamProtocol,
                           _ resultModel: T.Type,
                           completion: @escaping ApiCompletionRequest<T>
    )
}

protocol ApiRestCacheProtocol {
    func setCachePolicy()
}
