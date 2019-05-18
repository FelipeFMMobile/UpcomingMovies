//
//  AppDelegate.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 30/03/2018.
//  Copyright © 2018 FMMobile. All rights reserved.
//

import UIKit
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions 
                   launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    appTheme()
    
    initSdks()
    
    return true
  }
  
  func appTheme() {
    //theme of SVProgressHUD
    SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
  }

  func applicationWillResignActive(_ application: UIApplication) {
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
  }

  func applicationWillTerminate(_ application: UIApplication) {
  }
}

extension AppDelegate: SdkControlProtocol {
  func initSdks() {
    let firebase: SdkProtocol = FirebaseSdk()
    firebase.initialization()
  }
}
