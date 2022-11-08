//
//  UpcomingListTests.swift
//  UpComingMoviesTests
//
//  Created by Felipe Menezes on 02/06/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import XCTest
@testable import UpComingMovies
import OHHTTPStubs
import Nimble

/// UpComingListViewModelTests
/// Important note: none of this tests are covering failure scenarios, this will probably revised later
class UpComingListViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        HTTPStubs.setEnabled(true)
        HTTPStubs.onStubActivation { (request: URLRequest, stub: HTTPStubsDescriptor, _: HTTPStubsResponse) in
            print("[OHHTTPStubs] Request to \(request.url!) has been stubbed with \(String(describing: stub.name))")
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        HTTPStubs.removeAllStubs()
        
    }
    
    func stubFor(contract: String, statusCode: Int32 = 200) {
        stub(condition: isHost("api.themoviedb.org")) { _ in
            let stubPath = OHPathForFile(contract, type(of: self))
            return fixture(filePath: stubPath!, status: statusCode, headers: ["Content-Type": "application/json"])
        }
    }
    
    func testGetMoviewInfo_DetailNotNil() {
        stubFor(contract: "MovieDetail.json")
        let viewModel: UpComingListViewModelProtocol = UpComingListViewModel()
        let promise = expectation(description: "resultExpectation")
        if let object = objectForContract(contract: "ListMovie", PaginationModelCodable<MoviesModelCodable>.self) {
            if let movie = object.results?.first {
                viewModel.getMovieInfo(movie: movie) { result in
                    switch result {
                    case .success:
                        expect((viewModel as? UpComingListViewModel)?.detailMovie)
                                .to(beAKindOf(MoviesDetailModelCodable.self))
                        expect((viewModel as? UpComingListViewModel)?.detailMovie).toNot(beNil())
                    case .failure:
                        XCTFail("Testing failing")
                    }
                    promise.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testGetMoviewInfo_DetailMustFail() {
        stubFor(contract: "MovieDetail.json", statusCode: 401)
        let viewModel: UpComingListViewModelProtocol = UpComingListViewModel()
        let promise = expectation(description: "resultExpectation")
        if let object = objectForContract(contract: "ListMovie", PaginationModelCodable<MoviesModelCodable>.self) {
            if let movie = object.results?.first {
                viewModel.getMovieInfo(movie: movie) { result in
                    switch result {
                    case .success:
                        XCTFail("Testing failing")
                    case .failure(let error):
                        expect(error).toNot(beNil())
                    }
                    promise.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }

    func testGetGenres_GenreListNotEmpty() {
        stubFor(contract: "Genre.json")
        let viewModel: UpComingListViewModelProtocol = UpComingListViewModel()
        let promise = expectation(description: "resultExpectation")
        viewModel.getGenres { result in
            switch result {
            case .success:
                expect((viewModel as? UpComingListViewModel)?.genreList).to(beAKindOf(GenreListModelCodable.self))
                expect((viewModel as? UpComingListViewModel)?.genreList?.genres).toNot(beEmpty())
            case .failure:
                XCTFail("Testing failing")
            }
            promise.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }

    func testGetGenres_GenreListMustFail() {
        stubFor(contract: "Genre.json", statusCode: 401)
        let viewModel: UpComingListViewModelProtocol = UpComingListViewModel()
        let promise = expectation(description: "resultExpectation")
        viewModel.getGenres { result in
            switch result {
            case .success:
                XCTFail("Testing failing")
             case .failure(let error):
                expect(error).toNot(beNil())
            }
            promise.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }

    func testGetMovies_MoviesNotEmpty() {
        stubFor(contract: "ListMovie.json")
        let viewModel: UpComingListViewModelProtocol = UpComingListViewModel()
        let promise = expectation(description: "resultExpectation")
        viewModel.getUpCommingMovies { result in
            switch result {
            case .success:
                expect((viewModel as? UpComingListViewModel)?.movies).toNot(beEmpty())
            case .failure:
                XCTFail("Testing failing")
            }
            promise.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testGetMovies_MoviesMustFail() {
        stubFor(contract: "ListMovie.json", statusCode: 401)
        let viewModel: UpComingListViewModelProtocol = UpComingListViewModel()
        let promise = expectation(description: "resultExpectation")
        viewModel.getUpCommingMovies { result in
            switch result {
            case .success:
                XCTFail("Testing failing")
            case .failure(let error):
                expect(error).toNot(beNil())
            }
            promise.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }

    func testResePage_CurrentPageEqualOne() {
        stubFor(contract: "ListMovie.json")
        let viewModel = UpComingListViewModel()
        let promise = expectation(description: "resultExpectation")
        viewModel.getUpCommingMovies { result in
            switch result {
            case .success:
                expect(viewModel.movies).toNot(beEmpty())
                viewModel.resetPage()
                expect(viewModel.currentPage).to(equal(1))
                expect(viewModel.movies).to(beEmpty())
            case .failure:
                XCTFail("Testing failing")
            }
            promise.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testForwardPage_CurrentPageEqualTwo() {
        stubFor(contract: "ListMovie.json")
        let viewModel = UpComingListViewModel()
        let promise = expectation(description: "resultExpectation")
        viewModel.getUpCommingMovies { result in
            switch result {
            case .success:
                expect(viewModel.movies).toNot(beEmpty())
                viewModel.forwardPage()
                expect(viewModel.currentPage).to(equal(2))
            case .failure:
                XCTFail("Testing failing")
            }
            promise.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testDataSetNumberSection_EqualOne() {
        stubFor(contract: "ListMovie.json")
        let viewModel = UpComingListViewModel()
        let promise = expectation(description: "resultExpectation")
        viewModel.getUpCommingMovies { result in
            switch result {
            case .success:
                expect(viewModel.movies).toNot(beEmpty())
                expect(viewModel.numberOfSections()).to(beGreaterThanOrEqualTo(1))
            case .failure:
                XCTFail("Testing failing")
            }
            promise.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testDataSetNumberRowsInSection_GreatEqualOne() {
        stubFor(contract: "ListMovie.json")
        let viewModel = UpComingListViewModel()
        let promise = expectation(description: "resultExpectation")
        viewModel.getUpCommingMovies { result in
            switch result {
            case .success:
                expect(viewModel.movies).toNot(beEmpty())
                expect(viewModel.numRowsSection(section: 1)).to(beGreaterThanOrEqualTo(1))
            case .failure:
                XCTFail("Testing failing")
            }
            promise.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testDataSetValueForCellPositionOne_MatchMovieListOne() {
        stubFor(contract: "ListMovie.json")
        let viewModel = UpComingListViewModel()
        let promise = expectation(description: "resultExpectation")
        viewModel.getUpCommingMovies { result in
            switch result {
            case .success:
                expect(viewModel.movies).toNot(beEmpty())
                expect(viewModel.movies.first).toNot(beNil())
                if let firstPosition = viewModel.movies.first {
                    let pos = viewModel.valueForCellPosition(indexPath: IndexPath(item: 0, section: 0))?.idM ?? 0
                    expect(pos).to(equal(firstPosition.idM))
                }
            case .failure:
                XCTFail("Testing failing")
            }
            promise.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testGetMovieInfo_expectationResultInfo() {
        stubFor(contract: "ListMovie.json")
        let upcommingMovieApi: UpComingListApiProtocol = UpComingListApi()
        let promise = expectation(description: "resultExpectation")
        upcommingMovieApi.requestMovies(page: 0) { result in
            switch result {
            case .success(let model):
                expect(model).to(beAKindOf(PaginationModelCodable<MoviesModelCodable>.self))
                expect(model.results?.first).toNot(beNil())
            case .failure:
                XCTFail("Testing failing")
            }
            promise.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testRequestMovies_expectationResultInfo_ContractNulls() {
        stubFor(contract: "ListMovieRequired.json")
        let upcommingMovieApi: UpComingListApiProtocol = UpComingListApi()
        let promise = expectation(description: "resultExpectation")
        upcommingMovieApi.requestMovies(page: 0) { result in
            switch result {
            case .success(let model):
                expect(model).to(beAKindOf(PaginationModelCodable<MoviesModelCodable>.self))
                expect(model.results?.first).toNot(beNil())
            case .failure:
                XCTFail("Testing failing")
            }
            promise.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testRequestGenres_expectationResultInfo() {
        stubFor(contract: "Genre.json")
        let upcommingMovieApi: UpComingListApiProtocol = UpComingListApi()
        let promise = expectation(description: "resultExpectation")
        upcommingMovieApi.requestGenres { result in
            switch result {
            case .success(let model):
                expect(model).to(beAKindOf(GenreListModelCodable.self))
                expect(model).toNot(beNil())
            case .failure:
                XCTFail("Testing failing")
            }
            promise.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }

    func testRequestGenres_expectationResultFail() {
        stubFor(contract: "Genre.json", statusCode: 401)
        let upcommingMovieApi: UpComingListApiProtocol = UpComingListApi()
        let promise = expectation(description: "resultExpectation")
        upcommingMovieApi.requestGenres { result in
            switch result {
            case .success:
                XCTFail("Testing failing")
            case .failure(let error):
                expect(error).toNot(beNil())
            }
            promise.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }

    func testRequestMovieDetail_expectationResultInfo() {
        stubFor(contract: "MovieDetail.json")
        let upcommingMovieApi: UpComingListApiProtocol = UpComingListApi()
        let promise = expectation(description: "resultExpectation")
        if let object = objectForContract(contract: "ListMovie", PaginationModelCodable<MoviesModelCodable>.self) {
            if let movie = object.results?.first {
                upcommingMovieApi.requestMoviesDetail(movie: movie) { result in
                    switch result {
                    case .success(let model):
                        expect(model).to(beAKindOf(MoviesDetailModelCodable.self))
                        expect(model).toNot(beNil())
                    case .failure:
                        XCTFail("Testing failing")
                    }
                    promise.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }

    func objectForContract<T>(contract: String, _ type: T.Type) -> T? where T: Decodable {
        if let path = Bundle(for: UpComingListApiTests.self).path(forResource: contract, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let result = try decoder.decode(type, from: data)
                return result
            } catch {
                // handle error
            }
        }
        return nil
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
