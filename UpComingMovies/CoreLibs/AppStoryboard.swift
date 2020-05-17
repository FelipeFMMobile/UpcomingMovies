//
//  AppStoryboard.swift
//  UpComingMovies
//
//  Created by FelipeMenezes on 17/05/20.
//  Copyright © 2020 FMMobile. All rights reserved.
//

import Foundation

protocol AppStoryboardProtocol {
    func getName() -> String
}

enum AppStoryboard: String {
    case main
    case list
}

extension AppStoryboard: AppStoryboardProtocol {
    
    // swiftlint:disable force_cast
    static func instantiate<T>(_ appStoryboard: AppStoryboard) -> T where T: UIViewController {
        let storyboard = UIStoryboard(name: appStoryboard.getName(), bundle: nil)
        let identifier = NSStringFromClass(T.self).components(separatedBy: ".").last ?? ""
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    
    func getName() -> String {
        switch self {
        case .main:
            return "Main"
        case .list:
            return "UpComingListStoryboard"
        }
    }
}
