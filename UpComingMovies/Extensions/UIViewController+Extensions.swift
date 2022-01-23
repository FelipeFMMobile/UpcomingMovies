//
//  UIViewController+Extensions.swift
//  UpComingMovies
//
//  Created by FelipeMenezes on 18/05/20.
//  Copyright © 2020 FMMobile. All rights reserved.
//

import Foundation
import SVProgressHUD
import UpcomingMoviesApi

extension UIViewController {
    // swiftlint:disable force_cast
    static func instantiate<T>(_ appStoryboard: AppStoryboard) -> T where T: UIViewController {
        let storyboard = UIStoryboard(name: appStoryboard.getName(), bundle: nil)
        let identifier = NSStringFromClass(T.self).components(separatedBy: ".").last ?? ""
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    
    func displayError(_ error: Error) {
        guard let error = error as? ApiError else { return }
        var errorMessage = "Some error"
        switch error {
        case .domainFail:
            errorMessage = "Networking error, check your connection"
        case .contentSerializeError:
            errorMessage = "Networking error, check your connection and try again later"
        case .networkingError(let nSError):
            errorMessage = "Networking error, check your connection and try again later \(nSError.localizedDescription)"
        case .statusCodeError(let statusCode):
            errorMessage = "Service error \(statusCode), try again later"
        default:
            break
        }
        DispatchQueue.main.async {
            SVProgressHUD.show(withStatus: errorMessage)
        }
    }
}
