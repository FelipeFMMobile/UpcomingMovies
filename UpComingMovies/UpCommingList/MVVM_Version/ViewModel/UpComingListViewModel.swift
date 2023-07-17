//
//  UpComingListViewModel.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 30/03/2018.
//  Copyright © 2019 FMMobile. All rights reserved.
//
//  SOLID: Single Responsibility Principle, Interface Segregation
//

import SwiftApiSDK
import Foundation

protocol UpcomingApiProtocol { 
    var api: UpComingListApi { get }
}

protocol ViewTitleInfoProtocol { 
    var title: String { get }
}

protocol UpComingListViewModelProtocol: UpcomingApiProtocol {
    func getMovieInfo(movie: MoviesModelCodable, complete: @escaping (Result<Bool, ApiError>) -> Void)
    func getGenres(complete: @escaping (Result<Bool, ApiError>) -> Void)
    func getUpCommingMovies(complete: @escaping (Result<Bool, ApiError>) -> Void)
    func resetPage()
    func forwardPage()
}

class UpComingListViewModel: UpComingListViewModelProtocol, ViewModelCoordinator {
    weak var coordinatorDelegate: AppCoordinatorDelegate?

    var api = UpComingListApi()

    var currentPage = 1
    var maxPages = 1

    var genreList: GenreListModelCodable?
    var detailViewModel = DetailUpCommingListViewModel(movie: nil)
    var detailMovie: MoviesDetailModelCodable?
    var envData = EnviromentData()

    var movies = [MoviesModelCodable]()
    
    // MARK: Services
    /// getMovieInfo
    func getMovieInfo(movie: MoviesModelCodable, complete: @escaping (Result<Bool, ApiError>) -> Void) {
        api.requestMoviesDetail(movie: movie) { [weak self] resultInfo in
            switch resultInfo {
            case .success(let model):
                self?.detailMovie = model
                DispatchQueue.main.async {
                    self?.detailViewModel = DetailUpCommingListViewModel(movie: model)
                    complete(.success(true))
                }
            case .failure(let error):
                complete(.failure(error))
            }
        }
    }

    /// getGenres
    func getGenres(complete: @escaping (Result<Bool, ApiError>) -> Void) {
        api.requestGenres { [weak self] resultInfo in
            switch resultInfo {
            case .success(let model):
                self?.genreList = model
                complete(.success(true))
            case .failure(let error):
                complete(.failure(error))
            }
        }
    }

    /// getUpCommingMovies
    func getUpCommingMovies(complete: @escaping (Result<Bool, ApiError>) -> Void) {
        api.requestMovies(page: currentPage) { [weak self] resultInfo in
            switch resultInfo {
            case .success(let model):
                self?.maxPages = model.totalPages
                if let results = model.results {
                    self?.movies += results
                    let movieMark = results.map { EnviromentData.MovieMark(idM: $0.idM, isFavorite: false) }
                    self?.envData.favoritesMovies += movieMark
                    complete(.success(true))
                }
            case .failure(let error):
                complete(.failure(error))
            }
        }
    }
}

extension UpComingListViewModel: UpComingTableViewDataSetProtocol {
    func numberOfSections() -> Int {
        return 1
    }
    
    func numRowsSection(section: Int) -> Int {
        return movies.count
    }
    
    func valueForCellPosition(indexPath: IndexPath) -> MoviesModelCodable? {
        return movies[indexPath.row]
    }
    
    public func resetPage() {
        self.currentPage = 1
        movies.removeAll()
    }

    public func forwardPage() {
        if self.currentPage < maxPages {
            currentPage += 1
        }
    }
}

extension UpComingListViewModel: UpComingSwiftUIDataSetProtocol {
    func genreForMovie(movie: MoviesModelCodable) -> GenreModelCodable? {
        return genreList?.genresForMovie(movie: movie)?.first
    }
}

extension UpComingListViewModel: ViewTitleInfoProtocol {
    var title: String {
        return "Upcoming Movies"
    }
}
