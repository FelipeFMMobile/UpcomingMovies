//
//  AppTheme.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 23/01/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

import SVProgressHUD
import UIKit

protocol AppThemeProtocol {
    func configureTheme()
}

struct AppTheme: AppThemeProtocol {
    // Theme of SVProgressHUD
    func configureTheme() {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
    }
}
