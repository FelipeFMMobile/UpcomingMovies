//
//  HttpMethod.swift
//  UpcomingMoviesApi
//
//  Created by FMMobile on 19/05/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import Foundation

enum HttpMethod {
  case GET
  case POST
  case PUT
  case DELETE
  case PATCH
  
  func verb() -> String {
    
    switch self {
    case .GET:
      return "GET"
    case .POST:
      return "POST"
    case .PUT:
      return "PUT"
    case .DELETE:
      return "DELETE"
    case .PATCH:
      return "PATCH"
      
    }
  }
}
