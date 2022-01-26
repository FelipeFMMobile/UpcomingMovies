//
//  ModelData.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 24/01/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

import Foundation

struct PreviewModelData {
    static let genres: GenreListModelCodable = load("Genre.json")
    static let movies: PaginationModelCodable<MoviesModelCodable> = load("ListMovie.json")
    static let movieDetail: MoviesDetailModelCodable = load("MovieDetail.json")
    static var cellModel: ListMoviesCellModel = ListMoviesCellModel(genre: PreviewModelData.genres.genres!.first!,
                                                             movie: PreviewModelData.movies.results!.first!)
    static var viewModel: UpComingListViewModel = {
        let model = UpComingListViewModel()
        model.genreList = PreviewModelData.genres
        model.movies = PreviewModelData.movies.results!
        return model
    }()

    static var detailViewModel: DetailUpCommingListViewModel = {
        return DetailUpCommingListViewModel(movie: PreviewModelData.movieDetail)
    }()
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
