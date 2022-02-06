//
//  ModelData.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 24/01/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

struct PreviewData {
    static let genres: GenreListModelCodable = load("Genre.json")
    static let movies: PaginationModelCodable<MoviesModelCodable> = load("ListMovie.json")
    static let movieDetail: MoviesDetailModelCodable = load("MovieDetail.json")
    static var cellModel: ListMoviesCellModel = ListMoviesCellModel(genre: PreviewData.genres.genres!.first!,
                                                             movie: PreviewData.movies.results!.first!)
    static var cellModel2: ListMoviesCellModel = ListMoviesCellModel(genre: PreviewData.genres.genres!.last!,
                                                             movie: PreviewData.movies.results!.last!)
    static var viewModel: UpComingListViewModel = {
        let model = UpComingListViewModel()
        model.genreList = PreviewData.genres
        model.movies = PreviewData.movies.results!
        return model
    }()

    static var detailViewModel: DetailUpCommingListViewModel = {
        return DetailUpCommingListViewModel(movie: PreviewData.movieDetail)
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
