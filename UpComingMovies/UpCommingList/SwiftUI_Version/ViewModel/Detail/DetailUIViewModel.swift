//
//  DetailUIViewModel.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 28/03/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

import UIKit
import SwiftApiSDK

class DetailUIViewModel: ObservableObject {
    @Published var movie: MoviesDetailModelCodable? {
        didSet {
            fillData()
        }
    }
    var movieInfo: MoviesModelCodable?

    var title: String = ""
    var posterPath: URL = URL(string: "some")!
    var overview: String = "Some overview"
    var releaseDate: String = "10/10/2010"
    var genresString: String = "Genre"
    
    private var api = UpComingListApi()
    
    init(movie: MoviesModelCodable) {
        self.movieInfo = movie
    }
    
    @MainActor
    func detail() async throws {
        guard let movie = self.movieInfo else { throw ApiError.contentSerializeError(nil) }
        self.movie = try await detailVM(movie: movie)
    }
 
    private func fillData() {
        guard let movie = movie else { return }
        title = movie.title
        overview = movie.overview
        let url = ServerConfig.imagesBaseUrl + movie.posterPath
        if let url = URL(string: url) {
            posterPath = url
        }
        let formatter = DateFormatter()
        if let release = movie.releaseDate {
            formatter.dateFormat = ServerConfig.dateFormat
            if let date = formatter.date(from: release) {
                formatter.dateFormat = "d MMM"
                let sDate = formatter.string(from: date)
                releaseDate = "Comming on " + sDate
            }
        }
        let array = movie.genres?.map { $0.name ?? "" }
        genresString = array?.joined(separator: ", ") ?? ""
    }

    private func detailVM(movie: MoviesModelCodable) async throws -> MoviesDetailModelCodable {
        typealias ApiContinuation = CheckedContinuation<MoviesDetailModelCodable, Error>
        return try await withCheckedThrowingContinuation { (continuation: ApiContinuation) in
            api.requestMoviesDetail(movie: movie) { result in
                switch result {
                case .success(let model):
                    continuation.resume(returning: model)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

}
