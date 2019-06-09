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
  func getMovieInfo(movie: MoviesModelCodable, complete: @escaping () -> Void)
  func getGenres(complete: @escaping () -> Void)
  func getUpCommingMovies(complete: @escaping () -> Void)
}

class UpComingListViewModel: UpComingListViewModelProtocol { 
  
  var api = UpComingListApi()
  
  var currentPage = 1
  var maxPages = 1
  
  var genreList: GenreListModelCodable?
  
  var movies = [MoviesModelCodable]()
  var detailMovie: MoviesDetailModelCodable?
  
  ///getMovieInfo
  func getMovieInfo(movie: MoviesModelCodable, complete: @escaping () -> Void) {
    api.requestMoviesDetail(movie: movie) { [weak self] resultInfo in
      self?.detailMovie = resultInfo.result
      complete()
    }
  }
  
  ///getGenres
  func getGenres(complete: @escaping () -> Void) {
    api.requestGenres { [weak self] resultInfo in
      self?.genreList = resultInfo.result
      complete()
    }
  }
  
  ///getUpCommingMovies
  func getUpCommingMovies(complete: @escaping () -> Void) {
    api.requestMovies(page: currentPage) { [weak self] resultInfo in
      self?.maxPages = resultInfo.result?.totalPages ?? 0
      if let results = resultInfo.result?.results {
        self?.movies += results
      }
      complete()
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

extension UpComingListViewModel: ViewBasicInfoProtocol {
  var title: String {
    get {
      return "Upcoming Movies"
    }
  }
}
