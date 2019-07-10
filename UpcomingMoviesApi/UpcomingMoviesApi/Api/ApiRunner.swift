//
//  ApiExecute.swift
//  UpcomingMoviesApi
//
//  Created by FMMobile on 19/05/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//
// SOLID: Liskov Substitution Principle, Fat Interface Principle
//

import Foundation

open class ApiRunner: ApiRestProtocol {

  /// enumerado que define o Content-Type da request
  var contentType: ContentType?
  
  var header: [String: String] = [:]
  
  func run<T>(method: HttpMethod, _ contentType: ContentType, endPoint: String, params: ParamsProtocol, 
              completion: @escaping (Bool, T?, URLRequest?, NSError?) -> Void) where T: Decodable {
    
    let session = URLSession.shared
    let urlString = WebDomain.domainForBundle().rawValue + endPoint
    guard let url = URL(string: urlString) else {
      completion(false, nil, nil, defaultError(errorType: .domainFail))
      return
    }
    var request = URLRequest(url: url)
    request.httpMethod = method.verb() //set http method as POST
    //HTTP Headers
    request.addValue(contentType.contentType(), forHTTPHeaderField: "Content-Type")
    request.addValue(contentType.contentType(), forHTTPHeaderField: "Accept")
    
    request.setValue("Apple", forHTTPHeaderField: "x-fabricante")
    request.setValue(UIDevice.current.model, forHTTPHeaderField: "x-modelo")
    request.setValue(UIDevice.current.systemVersion, forHTTPHeaderField: "x-sistema-operacional")
    
    //headers
    for value in header {
      request.setValue(value.value, forHTTPHeaderField: value.key)
    }
    
    request = params.buildParams(request: request)
    
    // Request
    let task = session.dataTask(with: request, completionHandler: { data, response, error in
      guard error == nil else {
        completion(false, nil, nil, NSError(domain: error?.localizedDescription ?? "", code: 0, userInfo: nil))
        return
      }
      
      let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
      var errorCode: DefaultErrorCodes = .responseCodableFail
      if statusCode == 200 {
        if let odata = data {
          let decoder = JSONDecoder()
          do {
            let result = try decoder.decode(T.self, from: odata)
            completion(true, result, request, nil)
            return
          } catch let jsonError { 
            errorCode = .responseCodableFail
            #if DEBUG 
            print(jsonError)
            #endif
          }
        } else {
          errorCode = .noDataResponse
        }
      } else {
        errorCode = .statusCodeError
      }
      completion(false, nil, request, self.defaultError(errorType: errorCode, statusCode))
    })
    task.resume()
  }
  
  func addHeaderValue(value: String, key: String) -> Bool {
    self.header[key] = value
    return self.header.contains(where: { $1 == value })
  }
  
  func clearHeaderValues() -> Bool {
    self.header.removeAll()
    return self.header.count == 0
  }
  
  func setAuthorization(value: String) -> Bool {
    return addHeaderValue(value: value, key: "Authorization")
  }
  
  private func defaultError(errorType: DefaultErrorCodes, _ errorCode: Int = 0) -> NSError {
    switch errorType {
    case .domainFail:
      return NSError(domain: "dominio ausente", code: errorType.rawValue, userInfo: nil)
    case .responseCodableFail:
      return NSError(domain: "response codable fail", code: errorType.rawValue, userInfo: nil)
    case .noDataResponse:
      return NSError(domain: "no data response fail", code: errorType.rawValue, userInfo: nil)
    case .statusCodeError:
      return NSError(domain: "erro no servidor \(errorCode)", code: errorCode, userInfo: nil)
    }
  }
  
}
