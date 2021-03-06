//
//  FirebaseSdk.swift
//  UpComingMovies
//
//  Created by FMMobile on 18/05/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
// 
// Note: SOLID principles - Dependency Inversion Principle
//

import Foundation
import Firebase

protocol SdkProtocol {
  func initialization() -> Bool
}

protocol SdkControlProtocol {
  func initSdks() 
}

// FireBase SDK Implementation Tools
class FirebaseSdk: SdkProtocol {
  func initialization() -> Bool {
    let hasInit = FirebaseApp.app() != nil
    if !hasInit { FirebaseApp.configure() }
    return FirebaseApp.app() != nil
  }
  
}
