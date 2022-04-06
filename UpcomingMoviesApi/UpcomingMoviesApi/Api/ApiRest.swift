//
//  Api.swift
//  UpcomingMoviesApi
//
//  Created by FMMobile on 19/05/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//
// SOLID: Liskov Substitution Principle, Fat Interface Principle
//

enum ApiErrorCodes: Int {
    case domainFail = 999, responseCodableFail = 997, noDataResponse = 996, statusCodeError = 995
}

open class ApiRest: ApiRunner {
    public override init() { super.init() }
}

extension ApiRest: ApiRestCacheProtocol {
    /// set cachePolicy using 
    func setCachePolicy() {
        let cacheDirectory = (NSSearchPathForDirectoriesInDomains(.cachesDirectory,
                                                                    .userDomainMask, true)[0] as String)
            .appendingFormat("/\(Bundle.main.bundleIdentifier ?? "cache")/" )
        self.configuration.urlCache = URLCache(memoryCapacity: 4 * 1024 * 1024,
                                               diskCapacity: 1 * 1024 * 1024,
                                               diskPath: cacheDirectory)
        self.configuration.requestCachePolicy = .useProtocolCachePolicy
    }
}
