//
//  Api.swift
//  UpcomingMoviesApi
//
//  Created by FMMobile on 19/05/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//
// SOLID: Liskov Substitution Principle, Fat Interface Principle
//

import Foundation

enum DefaultErrorCodes: Int {
  case domainFail = 999, responseCodableFail = 997, noDataResponse = 996, statusCodeError = 995
}

open class ApiRest: ApiRunner, ApiRestGetProtocol, ApiRestPostJsonProtocol {
  
  public override init() { super.init() }
  
  /// Get Post
  func get<T>(endPoint: String, params: [String: Any]?, 
              completion: @escaping (Bool, T?, URLRequest?, NSError?) -> Void) where T: Decodable {
    
    let getParams = GetParams(params: params ?? [:])
    self.run(method: HttpMethod.GET, ContentType.json, endPoint: endPoint, 
             params: getParams, completion: completion)
  }
  
  /// JsonBody Post
  func post<T>(endPoint: String, params: [String: Any]?, 
               completion: @escaping (Bool, T?, URLRequest?, NSError?) -> Void) where T: Decodable {
    let getParams = JsonBodyParams(params: params ?? [:])
    self.run(method: HttpMethod.GET, ContentType.json, endPoint: endPoint, 
             params: getParams, completion: completion)
  }
  
}
