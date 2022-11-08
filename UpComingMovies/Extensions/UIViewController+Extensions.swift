//
//  UIViewController+Extensions.swift
//  UpComingMovies
//
//  Created by FelipeMenezes on 18/05/20.
//  Copyright © 2020 FMMobile. All rights reserved.
//

import Foundation
import SVProgressHUD
import SwiftApiSDK

protocol UIViewControllerUtils {
    func displayError(_ error: Error)
}

extension UIViewControllerUtils {
    
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
        }
        DispatchQueue.main.async {
            SVProgressHUD.show(withStatus: errorMessage)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                SVProgressHUD.dismiss()
            }
        }
    }
}
