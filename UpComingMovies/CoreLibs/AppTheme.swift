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
    static let blackColor = Asset.black.color
    static let darkGrayColor = Asset.darkGray.color
    static let whiteColor = Asset.white.color

    // Theme of SVProgressHUD
    func configureTheme() {
        let standard = UINavigationBarAppearance()
        standard.configureWithOpaqueBackground()
        standard.backgroundColor = AppTheme.whiteColor
        UINavigationBar.appearance().standardAppearance = standard
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
    }
}
