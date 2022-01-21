//
//  ContentType.swift
//  UpcomingMoviesApi
//
//  Created by FMMobile on 19/05/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import Foundation

enum ContentType {
    case formurlencoded
    case json

    func contentType() -> String {
        switch self {
        case .formurlencoded:
            return "application/x-www-form-urlencoded"
        case .json:
            return "application/json"
        }
    }
}
