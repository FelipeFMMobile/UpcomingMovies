//
//  ListUIViewModelTests.swift
//  UpComingMoviesTests
//
//  Created by Felipe Menezes on 30/03/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

import XCTest
@testable import UpComingMovies
import OHHTTPStubs

class ListUIViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        HTTPStubs.setEnabled(true)
        HTTPStubs.onStubActivation { (request: URLRequest, stub: HTTPStubsDescriptor, _: HTTPStubsResponse) in
            print("[OHHTTPStubs] Request to \(request.url!) has been stubbed with \(String(describing: stub.name))")
        }
    }

    override func tearDownWithError() throws {
        HTTPStubs.removeAllStubs()
    }

    private func stubFor(contract: String, statusCode: Int32 = 200) {
        stub(condition: isHost("api.themoviedb.org")) { _ in
            let stubPath = OHPathForFile(contract, type(of: self))
            return fixture(filePath: stubPath!, status: statusCode, headers: ["Content-Type": "application/json"])
        }
    }

    @available(iOS 15.0.0, *)
    func testMoviesListSuccessfullLoadMovies() async throws {
        stubFor(contract: "ListMovie.json")
        let viewModel = ListUIViewModel()
        try await viewModel.moviesList()
        XCTAssertEqual(viewModel.movies.count, 20)
    }
    
    @available(iOS 15.0.0, *)
    func testMoviesListFailLoadMovies() async {
        stubFor(contract: "ListMovie.json", statusCode: 401)
        let viewModel = ListUIViewModel()
        do {
            try await viewModel.moviesList()
        } catch {
            XCTAssertEqual(viewModel.movies.count, 0)
        }
    }
    
    @available(iOS 15.0.0, *)
    func testMoviesListFailLoadMoviesWhenForwardPage() async {
        stubFor(contract: "ListMovie.json", statusCode: 401)
        let viewModel = ListUIViewModel()
        viewModel.forwardPage()
        do {
            try await viewModel.moviesList()
        } catch {
            XCTAssertEqual(viewModel.movies.count, 0)
        }
        XCTAssertEqual(viewModel.currentPage, 2)
    }

    @available(iOS 15.0.0, *)
    func testResetPageAfterForwardPageIsCorrect() async {
        let viewModel = ListUIViewModel()
        viewModel.forwardPage()
        XCTAssertEqual(viewModel.currentPage, 2)
        viewModel.forwardPage()
        XCTAssertEqual(viewModel.currentPage, 3)
        viewModel.resetPage()
        XCTAssertEqual(viewModel.currentPage, 1)
    }

    @available(iOS 15.0.0, *)
    func testDetailMoviesListSuccessfullLoadMovies() async throws {
        stubFor(contract: "ListMovie.json")
        let viewModel = ListUIViewModel()
        try await viewModel.moviesList()
        let first = try XCTUnwrap(viewModel.movies.first)
        let detailModel = DetailUIViewModel(movie: first)
        stubFor(contract: "MovieDetail.json")
        try await detailModel.detail()
        let movie = try XCTUnwrap(detailModel.movie)
        XCTAssertEqual(movie.title, "Godzilla: King of the Monsters")
    }
    
    @available(iOS 15.0.0, *)
    func testDetailMoviesListFailLoadMovies() async {
        stubFor(contract: "ListMovie.json")
        let viewModel = ListUIViewModel()
        try? await viewModel.moviesList()
        guard let first = viewModel.movies.first else {
            XCTFail("Failing loading movie")
            return
        }
        let detailModel = DetailUIViewModel(movie: first)
        stubFor(contract: "MovieDetail.json", statusCode: 401)
        try? await detailModel.detail()
        XCTAssertNil(detailModel.movie)
    }
    
    @available(iOS 15.0.0, *)
    func testRowMoviesListIsCorrect() async throws {
        stubFor(contract: "ListMovie.json")
        let viewModel = ListUIViewModel()
        try await viewModel.moviesList()
        guard let first = viewModel.movies.first else {
            XCTFail("Failing loading movie")
            return
        }
        let rowViewModel = MovieRowUIViewModel(movie: first)
        XCTAssertEqual(rowViewModel.title, "Godzilla: King of the Monsters")
        let second = viewModel.movies[1]
        let rowViewModel2 = MovieRowUIViewModel(movie: second)
        XCTAssertEqual(rowViewModel2.posterPath.relativeString, "https://image.tmdb.org/t/p/w185/")
    }

}
