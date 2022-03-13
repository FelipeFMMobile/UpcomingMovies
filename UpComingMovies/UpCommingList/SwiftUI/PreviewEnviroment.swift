//
//  ModelData.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 24/01/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

struct PreviewEnviroment {
    static var isPreviewing: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    static let genres: GenreListModelCodable = load("Genre.json")
    static let movies: PaginationModelCodable<MoviesModelCodable> = load("ListMovie.json")
    static let movieDetail: MoviesDetailModelCodable = load("MovieDetail.json")
    static var cellModel: ListMoviesCellModel = ListMoviesCellModel(genre: PreviewEnviroment.genres.genres!.first!,
                                                             movie: PreviewEnviroment.movies.results!.first!)
    static var cellModel2: ListMoviesCellModel = ListMoviesCellModel(genre: PreviewEnviroment.genres.genres!.last!,
                                                             movie: PreviewEnviroment.movies.results!.last!)
    static var viewModel: UpComingListViewModel = {
        let model = UpComingListViewModel()
        model.genreList = PreviewEnviroment.genres
        model.movies = PreviewEnviroment.movies.results!
        return model
    }()

    static var detailViewModel: DetailUpCommingListViewModel = {
        return DetailUpCommingListViewModel(movie: PreviewEnviroment.movieDetail)
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
