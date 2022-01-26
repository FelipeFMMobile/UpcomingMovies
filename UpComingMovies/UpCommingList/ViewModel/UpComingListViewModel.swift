//
//  UpComingListViewModel.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 30/03/2018.
//  Copyright © 2019 FMMobile. All rights reserved.
//
//  SOLID: Single Responsibility Principle, Interface Segregation
//

import Foundation

protocol UpcomingApiProtocol { 
    var api: UpComingListApi { get }
}

protocol ViewBasicInfoProtocol { 
    var title: String { get }
}

protocol UpComingListViewModelProtocol: UpcomingApiProtocol {
    func getMovieInfo(movie: MoviesModelCodable, complete: @escaping (Result<Bool, Error>) -> Void)
    func getGenres(complete: @escaping (Result<Bool, Error>) -> Void)
    func getUpCommingMovies(complete: @escaping (Result<Bool, Error>) -> Void)
    func resetPage()
    func forwardPage()
}

class UpComingListViewModel: UpComingListViewModelProtocol, ViewModelCoordinator, ObservableObject {
    var coordinatorDelegate: AppCoordinatorDelegate?
    
    var api = UpComingListApi()
    
    var currentPage = 1
    var maxPages = 1
    
    var genreList: GenreListModelCodable?
    
    @Published var movies = [MoviesModelCodable]()
    var detailMovie: MoviesDetailModelCodable!
    
    /// getMovieInfo
    func getMovieInfo(movie: MoviesModelCodable, complete: @escaping (Result<Bool, Error>) -> Void) {
        api.requestMoviesDetail(movie: movie) { [weak self] resultInfo in
            switch resultInfo {
            case .success(let model):
                self?.detailMovie = model
                complete(.success(true))
            case .failure(let error):
                complete(.failure(error))
            }
        }
    }
    
    /// getGenres
    func getGenres(complete: @escaping (Result<Bool, Error>) -> Void) {
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
    func getUpCommingMovies(complete: @escaping (Result<Bool, Error>) -> Void) {
        api.requestMovies(page: currentPage) { [weak self] resultInfo in
            switch resultInfo {
            case .success(let model):
                self?.maxPages = model.totalPages
                if let results = model.results {
                    DispatchQueue.main.async {
                        self?.movies += results
                    }
                }
                complete(.success(true))
            case .failure(let error):
                complete(.failure(error))
            }
        }
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

extension UpComingListViewModel: UpComingTableViewsDataSetProtocol {
    func numberOfSections() -> Int {
        return 1
    }
    
    func numRowsSection(section: Int) -> Int {
        return movies.count
    }
    
    func valueForCellPosition(indexPath: IndexPath) -> MoviesModelCodable? {
        return movies[indexPath.row]
    }
}

extension UpComingListViewModel: UpComingSwiftUIDataSetProtocol {
    func genreForMovie(movie: MoviesModelCodable) -> GenreModelCodable? {
        return genreList?.genresForMovie(movie: movie)?.first
    }
    
    public func instantiateDetailSegue(movie: MoviesModelCodable) {
        getMovieInfo(movie: movie, complete: { [weak self] result in
            switch result {
            case .success:
                if let movieInfo = self?.detailMovie {
                    self?.coordinatorDelegate?.gotoFlow("detailMovie", model: movieInfo)
                }
            case .failure(let error):
                break
                //self?.displayError(error)
            }
        })
    }
}

extension UpComingListViewModel: ViewBasicInfoProtocol {
    var title: String {
        return "Upcoming Movies"
    }
}
