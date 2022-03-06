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

enum AppStoryboard: String {
    case main
    case list
    case detail
}

extension AppStoryboard: AppStoryboardProtocol {
    func getName() -> String {
        switch self {
        case .main:
            return "Main"
        case .list:
            return "UpComingListStoryboard"
        case .detail:
            return "DetailUpComingListStoryboard"
        }
    }
}
