//
//  AppStoryboard.swift
//  UpComingMovies
//
//  Created by FelipeMenezes on 17/05/20.
//  Copyright © 2020 FMMobile. All rights reserved.
//

protocol AppStoryboardProtocol {
    func getName() -> String
}

enum AppStoryboardHUB: String {
    case detail
}

extension AppStoryboardHUB: AppStoryboardProtocol {
    func getName() -> String {
        switch self {
        case .detail:
            return "DetailUpComingListStoryboard"
        }
    }
}
