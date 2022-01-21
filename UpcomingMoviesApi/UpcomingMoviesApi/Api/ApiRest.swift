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

enum ApiErrorCodes: Int {
    case domainFail = 999, responseCodableFail = 997, noDataResponse = 996, statusCodeError = 995
}

open class ApiRest: ApiRunner {
    public override init() { super.init() }
}
