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
    
    var coordinator: UpCommingCoordinator?
    
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
        coordinator = UpCommingCoordinator(nav: UINavigationController())
        do {
            self.window?.rootViewController = try coordinator?.start(.none).navigationController
        } catch {
            debugPrint("error initiate coordinator UpCommingCoordinator \(error.localizedDescription)")
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
