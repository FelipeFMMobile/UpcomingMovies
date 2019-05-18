//
//  FirebaseSdk.swift
//  UpComingMovies
//
//  Created by FMMobile on 18/05/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import Foundation
import Firebase

protocol SdkProtocol {
  func initialization()
}

protocol SdkControlProtocol {
  func initSdks()
}

class FirebaseSdk: SdkProtocol {
  func initialization() {
    FirebaseApp.configure()
  }
  
}
