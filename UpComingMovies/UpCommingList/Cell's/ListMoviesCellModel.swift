//
//  ListMoviesCellModel.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 01/04/2018.
//  Copyright © 2018 FMMobile. All rights reserved.
//

import UIKit

class ListMoviesCellModel: NSObject {
  var title: String = ""
  var posterPath: URL?
  var releaseDate: String?
  var genreTitle: String = ""
  
  init(genre: GenreModelMap, movie: MoviesModelMap) {
    genreTitle = genre.name ?? ""
    title = movie.title
    let url = ServerConfig.imagesBaseUrl + (movie.posterPath ?? "")
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
  }
}
