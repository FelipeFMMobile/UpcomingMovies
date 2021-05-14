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

open class ApiRunner: NSObject, ApiRestProtocol {
    
    let configuration = URLSessionConfiguration.default
    
    /// enumerado que define o Content-Type da request
    var contentType: ContentType?
    
    var header: [String: String] = [:]
    
    public override init() { }
    
    func run<T>(method: HttpMethod, _ contentType: ContentType, endPoint: String, params: ParamsProtocol,
                completion: @escaping (Result<ResultRequest<T>, ApiError>) -> Void) where T: Decodable {
        
        let session = URLSession(configuration: configuration,
                                 delegate: self,
                                 delegateQueue: nil)
        let urlString = WebDomain.domainForBundle().rawValue + endPoint
        guard let url = URL(string: urlString) else {
            completion(.failure(.domainFail))
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
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            guard error == nil else {
                let err = NSError(domain: error?.localizedDescription ?? "", code: statusCode)
                completion(.failure(.networkingError(err)))
                return
            }
            
            var errorCode: ApiError = .domainFail
            if statusCode == 200 {
                if let odata = data {
                    let decoder = JSONDecoder()
                    do {
                        let result = try decoder.decode(T.self, from: odata)
                        let resultRequest = ResultRequest(data: result, request: request)
                        completion(.success(resultRequest))
                        return
                    } catch let jsonError {
                        errorCode = .contentSerializeError(jsonError)
                        #if DEBUG
                        print(jsonError)
                        #endif
                    }
                } else {
                    errorCode = .contentSerializeError(nil)
                }
            } else {
                errorCode = .statusCodeError(statusCode)
            }
            completion(.failure(errorCode))
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
}

extension ApiRunner: URLSessionDataDelegate  {
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask,
                    willCacheResponse proposedResponse: CachedURLResponse,
                    completionHandler: @escaping (CachedURLResponse?) -> Void) {
        if proposedResponse.response.url?.scheme == "https" {
            let updatedResponse = CachedURLResponse(response: proposedResponse.response,
                                                    data: proposedResponse.data,
                                                    userInfo: proposedResponse.userInfo,
                                                    storagePolicy: .allowedInMemoryOnly)
            completionHandler(updatedResponse)
        } else {
            completionHandler(proposedResponse)
        }
    }
}
