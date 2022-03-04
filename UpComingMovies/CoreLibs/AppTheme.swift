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
    static let blackColor = UIColor(named: "Black")
    static let darkGrayColor = UIColor(named: "DarkGray")
    static let whiteColor = UIColor(named: "White")

    // Theme of SVProgressHUD
    func configureTheme() {
        let standard = UINavigationBarAppearance()
        standard.configureWithOpaqueBackground()
        standard.backgroundColor = AppTheme.whiteColor
        UINavigationBar.appearance().standardAppearance = standard
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
    }
}
