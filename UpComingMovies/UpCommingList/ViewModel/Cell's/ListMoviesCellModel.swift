//
//  ListMoviesCellModel.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 01/04/2018.
//  Copyright © 2018 FMMobile. All rights reserved.
//

import UIKit

protocol ListMoviesCellModelProtocol {
    var title: String  { get set }
    var posterPath: URL? { get set }
    var releaseDate: String { get set }
    var genreTitle: String { get set }
    init(genre: GenreModelCodable, movie: MoviesModelCodable)
}

class ListMoviesCellModel: NSObject, ListMoviesCellModelProtocol {
    var title: String = ""
    var posterPath: URL?
    var releaseDate: String = ""
    var genreTitle: String = ""
    var sinopses: String = ""
    
    required init(genre: GenreModelCodable, movie: MoviesModelCodable) {
        genreTitle = genre.name ?? ""
        title = movie.title
        let url = ServerConfig.imagesBaseUrl + (movie.posterPath ?? "")
        posterPath = URL(string: url)
        sinopses = movie.overview ?? ""
        let formatter = DateFormatter()
        guard let release = movie.releaseDate else { return }
        formatter.dateFormat = ServerConfig.dateFormat
        guard let date = formatter.date(from: release)  else { return }
        formatter.dateFormat = "d MMM"
        let sDate = formatter.string(from: date)
        releaseDate = "Comming on " + sDate
    }
}
