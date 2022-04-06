//
//  UpcomingListApi.swift
//  UpComingMovies
//
//  Created by FMMobile on 02/06/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import UpcomingMoviesApi

protocol UpComingListApiProtocol {
    typealias RequetsResult<T> = (_ result: Result<T, ApiError>) -> Void
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
        let apiParam = ApiParamFactory.basic.generate(endPoint: endpoint.path(), params: GetParams(params: params))
        api.run(param: apiParam, PaginationModelCodable<MoviesModelCodable>.self) { result, _ in
            switch result {
            case .success(let model):
                complete(.success(model))
            case .failure(let error):
                complete(.failure(error))
            }
        }
    }

    func requestGenres(complete: @escaping RequetsResult<GenreListModelCodable>) {
        let params = ["api_key": "1f54bd990f1cdfb230adb312546d765d"]
        let apiParam = ApiParamFactory.basic.generate(endPoint: UpcomingEndpoints.genres.path(),
                                                      params: GetParams(params: params))
        api.run(param: apiParam, GenreListModelCodable.self) { result, _ in
            switch result {
            case .success(let model):
                complete(.success(model))
            case .failure(let error):
                complete(.failure(error))
            }
        }
    }

    func requestMoviesDetail(movie: MoviesModelCodable, complete: @escaping RequetsResult<MoviesDetailModelCodable>) {
        let params = ["api_key": "1f54bd990f1cdfb230adb312546d765d"]
        let apiParam = ApiParamFactory.basic.generate(endPoint: UpcomingEndpoints.movie(String(movie.idM)).path(),
                                                      params: GetParams(params: params))
        api.run(param: apiParam, MoviesDetailModelCodable.self) { result, _ in
            switch result {
            case .success(let model):
                complete(.success(model))
            case .failure(let error):
                complete(.failure(error))
            }
        }
    }
}
