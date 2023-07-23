//
//  FirebaseSdk.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 18/05/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
// 
//

import Firebase

/// SDKProtocol abstraction to initialize all sdk dependencies in projet.
protocol SdkProtocol {
    @discardableResult
    func initialization() -> Bool
}

protocol SdkControlProtocol {
    func initSdks() 
}

// FireBase SDK Implementation Tools
struct FirebaseSdk: SdkProtocol {
    @discardableResult
    func initialization() -> Bool {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        return true
    }
}
