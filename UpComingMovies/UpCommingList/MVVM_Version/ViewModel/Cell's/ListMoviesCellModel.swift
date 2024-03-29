//
//  ListMoviesCellModel.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 01/04/2018.
//  Copyright © 2018 FMMobile. All rights reserved.
//

import UIKit
import SwiftApiSDK

protocol ListMoviesCellModelProtocol {
    var title: String  { get set }
    var posterPath: URL { get set }
    var releaseDate: String { get set }
    var genreTitle: String { get set }
    init(genre: GenreModelCodable, movie: MoviesModelCodable)
}

class ListMoviesCellModel: NSObject, ObservableObject, ListMoviesCellModelProtocol {
    var title: String = ""
    var posterPath: URL = URL(string: "https://www.apple.com")!
    var releaseDate: String = ""
    var genreTitle: String = ""
    var sinopses: String = ""
    var movieID: Int = 0
    @Published var isFavorite: Bool = false
    
    required init(genre: GenreModelCodable, movie: MoviesModelCodable) {
        genreTitle = genre.name ?? ""
        title = movie.title
        let url = ServerConfig.imagesBaseUrl + (movie.posterPath ?? "")
        if let url = URL(string: url) {
            posterPath = url
        }
        sinopses = movie.overview ?? ""
        let formatter = DateFormatter()
        guard let release = movie.releaseDate else { return }
        formatter.dateFormat = ServerConfig.dateFormat
        guard let date = formatter.date(from: release)  else { return }
        formatter.dateFormat = "d MMM"
        let sDate = formatter.string(from: date)
        releaseDate = "Comming on " + sDate
        movieID = movie.idM
    }
}
