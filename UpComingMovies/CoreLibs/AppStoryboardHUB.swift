//
//  AppStoryboard.swift
//  UpComingMovies
//
//  Created by FelipeMenezes on 17/05/20.
//  Copyright © 2020 FMMobile. All rights reserved.
//

import UIKit

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

    // swiftlint:disable force_cast
    func instantiate<T>() -> T where T: UIViewController {
        let storyboard = UIStoryboard(name: getName(), bundle: nil)
        let identifier = NSStringFromClass(T.self).components(separatedBy: ".").last ?? ""
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    // swiftlint:enable force_cast
}
