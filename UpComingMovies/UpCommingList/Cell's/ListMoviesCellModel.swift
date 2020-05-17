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
    var releaseDate: String? { get set }
    var genreTitle: String { get set }
    init(genre: GenreModelCodable, movie: MoviesModelCodable)
}

class ListMoviesCellModel: NSObject, ListMoviesCellModelProtocol {
    var title: String = ""
    var posterPath: URL?
    var releaseDate: String?
    var genreTitle: String = ""
    
    required init(genre: GenreModelCodable, movie: MoviesModelCodable) {
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
