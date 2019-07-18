//
//  UpcomingListApi.swift
//  UpComingMovies
//
//  Created by FMMobile on 02/06/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import Foundation
import UpcomingMoviesApi

struct RequestResultInfo<T> { 
  var result: T?
  var error: Error? 
}

protocol UpComingListApiProtocol {
  typealias RequetsResult<T> = (_ result: RequestResultInfo<T>) -> Void
  func requestMovies(page: Int, complete: @escaping RequetsResult<PaginationModelCodable<MoviesModelCodable>>)
  func requestGenres(complete: @escaping RequetsResult<GenreListModelCodable>)
  func requestMoviesDetail(movie: MoviesModelCodable, complete: @escaping RequetsResult<MoviesDetailModelCodable>)
}

class UpComingListApi: UpComingListApiProtocol {
  
  let api = ApiRest()
  
  func requestMovies(page: Int, 
                     complete: @escaping RequetsResult<PaginationModelCodable<MoviesModelCodable>>) {
    
    let params = ["api_key": "1f54bd990f1cdfb230adb312546d765d", "page": "\(page)"]
    api.get(endPoint: UpcomingEndpoints.upComing.rawValue, 
            params: params) {(_: Bool, result: PaginationModelCodable<MoviesModelCodable>?, 
                              _: URLRequest?, error: NSError?) in
            complete(RequestResultInfo(result: result, error: error))
    }
  }
  
  func requestGenres(complete: @escaping RequetsResult<GenreListModelCodable>) {
    let params = ["api_key": "1f54bd990f1cdfb230adb312546d765d"]
    api.get(endPoint: UpcomingEndpoints.genres.rawValue, 
            params: params) {(_: Bool, result: GenreListModelCodable?, 
                              _: URLRequest?, error: NSError?) in
              complete(RequestResultInfo(result: result, error: error))
    }
  }
  
  func requestMoviesDetail(movie: MoviesModelCodable, complete: @escaping RequetsResult<MoviesDetailModelCodable>) {
    let params = ["api_key": "1f54bd990f1cdfb230adb312546d765d"]
    api.get(endPoint: UpcomingEndpoints.movie.rawValue + String(movie.idM), 
            params: params) {(_: Bool, result: MoviesDetailModelCodable?, 
                              _: URLRequest?, error: NSError?) in
              complete(RequestResultInfo(result: result, error: error))
    }
  }
}
