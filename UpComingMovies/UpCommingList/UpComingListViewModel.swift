//
//  UpComingListViewModel.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 30/03/2018.
//  Copyright © 2018 FMMobile. All rights reserved.
//

import Foundation
#if !RX_NO_MODULE
  import RxSwift
  import RxCocoa
  import RxDataSources
#endif

class UpComingListViewModel {
  let api = UPComingListApi()
  var currentPage = 1
  var maxPages = 1
  var genreList: GenreListModelMap?
  var movies = Variable<[MoviesModelMap]?>([])
  var detailMovie: MoviesDetailModelMap?
  
  ///getMovieInfo
  open func getMovieInfo(movie: MoviesModelMap, complete: @escaping () -> Void) {
    api.requestMovieInfo(movie: movie) { [weak self] (movieModelMap) in
      self?.detailMovie = movieModelMap
      complete()
    }
  }
  
  ///getGenres
  open func getGenres(complete: @escaping () -> Void) {
    api.requestGenres(complete: { [weak self] (genreList) in
      self?.genreList = genreList
      complete()
    }) 
  }
  
  ///getUpCommingMovies
  open func getUpCommingMovies(complete: @escaping () -> Void) {
    api.requestUpComingMovies(page: currentPage, complete: { [weak self] (paginationMovies) in
       self?.maxPages = paginationMovies.totalPages
      if let results = paginationMovies.results {
        self?.movies.value! += results
      }
      complete()
    })
  }
  
  func numRowsSection(section: Int) -> Int {
    return movies.value?.count ?? 0
  }
  
  public func resetPage() {
    self.currentPage = 1
    movies.value?.removeAll()
  }
  
  public func forwardPage() {
    if self.currentPage < maxPages {
      currentPage += 1
    }
  }
}
