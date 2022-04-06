//
//  ApiExecute.swift
//  UpcomingMoviesApi
//
//  Created by FMMobile on 19/05/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//
// SOLID: Liskov Substitution Principle, Fat Interface Principle
//

open class ApiRunner: NSObject, ApiRestProtocol {

    let configuration = URLSessionConfiguration.default

    public func run<T>(param: ApiRestParamProtocol, _ resultModel: T.Type,
                       completion: @escaping ApiCompletionRequest<T>) where T: Decodable {

        let session = URLSession(configuration: configuration,
                                 delegate: self,
                                 delegateQueue: nil)
        let urlString = param.endPoint
        guard let url = URL(string: urlString) else {
            completion(.failure(ApiError.domainFail), nil)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = param.method.verb() // set http method as POST
        // HTTP Headers
        param.generateDefaultHeader()
        // headers
        for value in param.header.header {
            request.setValue(value.value, forHTTPHeaderField: value.key)
        }
        request = param.params.buildParams(request: request)
        // Request
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(.failure(ApiError.networkingError(NSError(domain: error?.localizedDescription ?? "",
                                                                     code: 0, userInfo: nil))), nil)
                return
            }

            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            var errorCode: ApiError = .statusCodeError(statusCode)
            if statusCode == 200 {
                if let odata = data {
                    let decoder = JSONDecoder()
                    do {
                        let result = try decoder.decode(T.self, from: odata)
                        completion(.success(result), request)
                        return
                    } catch let jsonError {
                        errorCode = .contentSerializeError(self.defaultError(errorType: .responseCodableFail,
                                                                             statusCode))
                        debugPrint(jsonError)
                    }
                } else {
                    errorCode = .contentSerializeError(self.defaultError(errorType: .noDataResponse,
                                                                         statusCode))
                }
            }
            completion(.failure(errorCode), request)
        })
        task.resume()
    }

    private func defaultError(errorType: ApiErrorCodes, _ errorCode: Int = 0) -> NSError {
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

extension ApiRunner: URLSessionDataDelegate {
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
