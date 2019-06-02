//
//  UpComingListApi.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 30/03/2018.
//  Copyright © 2018 FMMobile. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

enum ServicesEndpoints: String {
  case upComing = "movie/upcoming"
  case genres = "genre/movie/list"
  case movie = "movie/"
}

class UpComingListApiAlamo {

  let key = ServerConfig.key
  let language = "en-US"
    
  func requestUpComingMovies(page: Int, complete: @escaping (PaginationModelMap<MoviesModelMap>) -> Void) {
    let url = ServerConfig.domain+ServicesEndpoints.upComing.rawValue
    let parameters: [String: Any] = [
      "api_key": key,
      "language": language,
      "page": page
    ]

    Alamofire.request(url, method: .get, parameters: parameters, headers: nil)
      .responseObject { (response: DataResponse<PaginationModelMap<MoviesModelMap>>) in
        if let responseMap = response.result.value {
          complete(responseMap)
        } else {
          #if DEBUG
            debugPrint(response)
          #endif
        } 
    }
  }
  
  func requestGenres(complete: @escaping (GenreListModelMap) -> Void) {
    let url = ServerConfig.domain+ServicesEndpoints.genres.rawValue
    let parameters: [String: Any] = [
      "api_key": key,
      "language": language
    ]
    
    Alamofire.request(url, method: .get, parameters: parameters, headers: nil)
      .responseObject { (response: DataResponse<GenreListModelMap>) in
        if let responseMap = response.result.value {
          complete(responseMap)
        } else {
          #if DEBUG
            debugPrint(response)
          #endif
        } 
    }
  }

  func requestMovieInfo(movie: MoviesModelMap, complete: @escaping (MoviesDetailModelMap) -> Void) {
    let url = ServerConfig.domain + ServicesEndpoints.movie.rawValue + String(movie.idM)
    let parameters: [String: Any] = [
      "api_key": key,
      "language": language
    ]
    
    Alamofire.request(url, method: .get, parameters: parameters, headers: nil)
      .responseObject { (response: DataResponse<MoviesDetailModelMap>) in
        if let responseMap = response.result.value {
          complete(responseMap)
        } else {
          #if DEBUG
            debugPrint(response)
          #endif
        } 
    }
  }
}
