//
//  UpcomingListApi.swift
//  UpComingMovies
//
//  Created by FMMobile on 02/06/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import SwiftApiSDK

protocol UpComingListApiProtocol {
    typealias RequetsResult<T> = (_ result: Result<T, ApiError>) -> Void
    func requestMovies(page: Int, complete: @escaping RequetsResult<PaginationModelCodable<MoviesModelCodable>>)
    func requestGenres(complete: @escaping RequetsResult<GenreListModelCodable>)
    func requestMoviesDetail(movie: MoviesModelCodable, complete: @escaping RequetsResult<MoviesDetailModelCodable>)
}

final class UpComingListApi: UpComingListApiProtocol {
    
    private let api = ApiRest()
    
    private let apiKey = "2c767653e58ac61f2ef293863e254f5d"
    
    func requestMovies(page: Int,
                       complete: @escaping RequetsResult<PaginationModelCodable<MoviesModelCodable>>) {
        
        let params = ["api_key": apiKey, "page": "\(page)"]
        let endpoint = UpcomingEndpoints.upComing
        let apiParam = ApiParamFactory.basic.generate(domain: WebDomain.self,
                                                      endPoint: endpoint.path(),
                                                      params: GetParams(params: params))
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
        let params = ["api_key": apiKey]
        let apiParam = ApiParamFactory.basic.generate(domain: WebDomain.self,
                                                      endPoint: UpcomingEndpoints.genres.path(),
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
        let params = ["api_key": apiKey]
        let apiParam = ApiParamFactory.basic.generate(domain: WebDomain.self,
                                                      endPoint: UpcomingEndpoints.movie(String(movie.idM)).path(),
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
