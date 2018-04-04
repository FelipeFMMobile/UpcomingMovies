//
//  DetailUpCommingListViewModel.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 01/04/2018.
//  Copyright © 2018 FMMobile. All rights reserved.
//

import UIKit

class DetailUpCommingListViewModel: NSObject {
  var movie: MoviesDetailModelMap
  
  var title: String?
  var posterPath: URL?
  var overview: String?
  var releaseDate: String?
  var genresString: String?
  
  init(genres: [GenreModelMap]?, movie: MoviesDetailModelMap) {
    self.movie = movie
    title = movie.title
    overview = movie.overview
    let url = ServerConfig.imagesBaseUrl + movie.posterPath
    posterPath = URL(string: url)
    let formatter = DateFormatter() 
    if let release = movie.releaseDate {
      formatter.dateFormat = ServerConfig.dateFormat
      if let date = formatter.date(from: release) {
        formatter.dateFormat = "d MMM"
        let sDate = formatter.string(from: date)
        releaseDate = "Comming on " + sDate 
      }
    }
    let array = genres?.map { $0.name ?? "" }
    genresString = array?.joined(separator: ", ")
  }
}
