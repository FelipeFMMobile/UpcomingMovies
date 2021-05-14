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
    var error: ApiError?
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
        let endpoint = UpcomingEndpoints.upComing
        api.get(endPoint: endpoint, params: params, PaginationModelCodable<MoviesModelCodable>.self) { response in
            switch response {
            case .success(let result):
                complete(RequestResultInfo(result: result.data, error: nil))
            case .failure(let error):
                complete(RequestResultInfo(result: nil, error: error))
            }
        }
    }
    
    func requestGenres(complete: @escaping RequetsResult<GenreListModelCodable>) {
        let params = ["api_key": "1f54bd990f1cdfb230adb312546d765d"]
        api.get(endPoint: UpcomingEndpoints.genres,
                params: params, GenreListModelCodable.self) { response in
                switch response {
                case .success(let result):
                    complete(RequestResultInfo(result: result.data, error: nil))
                case .failure(let error):
                    complete(RequestResultInfo(result: nil, error: error))
                }
        }
    }
    
    func requestMoviesDetail(movie: MoviesModelCodable, complete: @escaping RequetsResult<MoviesDetailModelCodable>) {
        let params = ["api_key": "1f54bd990f1cdfb230adb312546d765d"]
        api.get(endPoint: UpcomingEndpoints.movie(String(movie.idM)),
                params: params, MoviesDetailModelCodable.self) { response in
                    switch response {
                    case .success(let result):
                        complete(RequestResultInfo(result: result.data, error: nil))
                    case .failure(let error):
                        complete(RequestResultInfo(result: nil, error: error))
                    }
        }
    }
}
