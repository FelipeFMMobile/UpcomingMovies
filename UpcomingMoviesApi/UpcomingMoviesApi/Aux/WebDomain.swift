//
//  WebDomain.swift
//  UpcomingMoviesApi
//
//  Created by FMMobile on 19/05/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import Foundation

struct ServerConfig {
  public static let dateFormat = "yyyy-MM-dd"
  public static let imagesBaseUrl = "https://image.tmdb.org/t/p/w185/"
  public static let key = "1f54bd990f1cdfb230adb312546d765d"
}

//* Domain control
//* Check target bundle to switch between domains 
//* Homolg and dev domains is not avalaible
enum WebDomain: String {
  case producao = "https://api.themoviedb.org/3/"
  case homolog = "https://homolog.themoviedb.org/3/"
  case dev = "localhost://api.themoviedb.org/3/"
  
  static func domainForBundle() -> WebDomain {
    if let bundleID = Bundle.main.bundleIdentifier {
      if bundleID.range(of: "homolog") != nil {
        return .homolog
      }
      if bundleID.range(of: "dev") != nil {
        return .dev
      }
    }
    return .producao
  }
  
  static func config() -> ServerConfig {
    return ServerConfig()
  }
}
