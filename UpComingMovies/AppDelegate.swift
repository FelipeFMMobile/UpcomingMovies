//
//  AppDelegate.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 30/03/2018.
//  Copyright © 2018 FMMobile. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var coordinator: AnyObject?
    
    var sdkDependency: [SdkProtocol] = [
        FirebaseSdk()
    ]
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        appTheme()
        
        initSdks()
        
        initViews()
        
        return true
    }
    
    func appTheme() {
        AppTheme().configureTheme()
    }
    
    func initViews() {
        self.window = UIWindow()
        if #available(iOS 14.0, *) {
            var coordinator = UpCommingCoordinatorHosting(nav: UINavigationController())
            self.window?.rootViewController = try? coordinator.start(.none).navigationController
            self.coordinator = coordinator
        } else {
            var coordinator = UpCommingCoordinator(nav: UINavigationController())
            self.window?.rootViewController = try? coordinator.start(.none).navigationController
            self.coordinator = coordinator
        }
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
        sdkDependency.forEach {
            $0.initialization()
        }
    }
}
