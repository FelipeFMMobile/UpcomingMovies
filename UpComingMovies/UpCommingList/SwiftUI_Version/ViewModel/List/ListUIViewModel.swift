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
    @Published private(set) var movies: [MoviesModelCodable]
    private(set) var title: String = "Upcoming Movies"
    private(set) var envData = EnviromentData()
    private var api = UpComingListApi()
    private var maxPages = 1
    private(set) var currentPage: Int = 1
    
    init(movies: [MoviesModelCodable] = [MoviesModelCodable]()) {
        self.movies = movies
    }

    @MainActor
    func moviesList() async throws {
        async let results = self.listMovies()
        self.movies += try await results
    }

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

    func forwardPage() {
        self.currentPage += 1
    }
    
    func resetPage() {
        self.movies.removeAll()
        self.currentPage = 1
    }
    
    // MARK: Scrolling Load
    func loadMore() async throws {
         forwardPage()
         try await moviesList()
    }

}
