//
//  ListUIViewModel.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 20/03/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

import Combine
import SwiftUI

class ListUIViewModel: ObservableObject {
    @Published var movies: [MoviesModelCodable] = [MoviesModelCodable]()
    @Published var title: String = "Upcoming Movies"

    var envData = EnviromentData()

    private var api = UpComingListApi()

    private var maxPages = 1
    private(set) var currentPage: Int = 1
    private var genreList: GenreListModelCodable?

    @available(iOS 15.0.0, *)
    @MainActor
    func moviesList() async throws {
        if currentPage == 1 {
            self.genreList = try await genres()
        }
        let results = try await listMovies()
        let movieMark = results.map { EnviromentData.MovieMark(idM: $0.idM, isFavorite: false) }
        envData.favoritesMovies += movieMark
        movies += results
    }

    @available(iOS 15.0.0, *)
    private func listMovies() async throws -> [MoviesModelCodable] {
        typealias ApiContinuation = CheckedContinuation<[MoviesModelCodable], Error>
        return try await withCheckedThrowingContinuation { (continuation: ApiContinuation) in
            api.requestMovies(page: currentPage) { [weak self] resultInfo in
                switch resultInfo {
                case .success(let model):
                    self?.maxPages = model.totalPages
                    if let results = model.results {
                        continuation.resume(returning: results)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    @available(iOS 15.0.0, *)
    private func genres() async throws -> GenreListModelCodable {
        typealias ApiContinuation = CheckedContinuation<GenreListModelCodable, Error>
        return try await withCheckedThrowingContinuation { (continuation: ApiContinuation) in
            api.requestGenres { result in
                switch result {
                case .success(let model):
                    continuation.resume(returning: model)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func forwardPage() {
        self.currentPage += 1
    }
    
    func resetPage() {
        self.movies.removeAll()
        self.currentPage = 1
    }
}
