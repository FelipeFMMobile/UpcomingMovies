//
//  UIViewController+Extensions.swift
//  UpComingMovies
//
//  Created by FelipeMenezes on 18/05/20.
//  Copyright © 2020 FMMobile. All rights reserved.
//

import Foundation

extension UIViewController {
    // swiftlint:disable force_cast
    static func instantiate<T>(_ appStoryboard: AppStoryboard) -> T where T: UIViewController {
        let storyboard = UIStoryboard(name: appStoryboard.getName(), bundle: nil)
        let identifier = NSStringFromClass(T.self).components(separatedBy: ".").last ?? ""
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }    
}
