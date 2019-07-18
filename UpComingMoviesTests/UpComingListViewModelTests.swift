//
//  UpcomingListTests.swift
//  UpComingMoviesTests
//
//  Created by FMMobile on 02/06/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import XCTest
@testable import UpComingMovies
import OHHTTPStubs
import Nimble

class UpComingListViewModelTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    OHHTTPStubs.setEnabled(true)
    OHHTTPStubs.onStubActivation { (request: URLRequest, stub: OHHTTPStubsDescriptor, _: OHHTTPStubsResponse) in
      print("[OHHTTPStubs] Request to \(request.url!) has been stubbed with \(String(describing: stub.name))")
    }
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    OHHTTPStubs.removeAllStubs()
    
  }
  
  func stubFor(contract: String) {
    stub(condition: isHost("api.themoviedb.org")) { _ in
      let stubPath = OHPathForFile(contract, type(of: self))
      return fixture(filePath: stubPath!, status: 200, headers: ["Content-Type": "application/json"])
    }
  }
  
  func testGetMoviewInfo_DetailNotNil() {
    stubFor(contract: "MovieDetail.json")
    let viewModel: UpComingListViewModelProtocol = UpComingListViewModel()
    let promise = expectation(description: "resultExpectation")
    if let object = objectForContract(contract: "ListMovie", PaginationModelCodable<MoviesModelCodable>.self) {
      if let movie = object.results?.first {
        viewModel.getMovieInfo(movie: movie) { 
          expect((viewModel as? UpComingListViewModel)?.detailMovie).to(beAKindOf(MoviesDetailModelCodable.self))
          expect((viewModel as? UpComingListViewModel)?.detailMovie).toNot(beNil())
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
    viewModel.getGenres {
      expect((viewModel as? UpComingListViewModel)?.genreList).to(beAKindOf(GenreListModelCodable.self))
      expect((viewModel as? UpComingListViewModel)?.genreList?.genres).toNot(beEmpty())
      promise.fulfill()
    }
    waitForExpectations(timeout: 3, handler: nil)
  }
  
  func testGetMovies_MoviesNotEmpty() {
    stubFor(contract: "ListMovie.json")
    let viewModel: UpComingListViewModelProtocol = UpComingListViewModel()
    let promise = expectation(description: "resultExpectation")
    viewModel.getUpCommingMovies {
      expect((viewModel as? UpComingListViewModel)?.movies).toNot(beEmpty())
      promise.fulfill()
    }
    waitForExpectations(timeout: 3, handler: nil)
  }
  
  func testResePage_CurrentPageEqualOne() {
    stubFor(contract: "ListMovie.json")
    let viewModel = UpComingListViewModel()
    let promise = expectation(description: "resultExpectation")
    viewModel.getUpCommingMovies {
      expect(viewModel.movies).toNot(beEmpty())
      viewModel.resetPage()
      expect(viewModel.currentPage).to(equal(1))
      expect(viewModel.movies).to(beEmpty())
      promise.fulfill()
    }
    waitForExpectations(timeout: 3, handler: nil)
  }
  
  func testForwardPage_CurrentPageEqualTwo() {
    stubFor(contract: "ListMovie.json")
    let viewModel = UpComingListViewModel()
    let promise = expectation(description: "resultExpectation")
    viewModel.getUpCommingMovies {
      expect(viewModel.movies).toNot(beEmpty())
      viewModel.forwardPage()
      expect(viewModel.currentPage).to(equal(2))
      promise.fulfill()
    }
    waitForExpectations(timeout: 3, handler: nil)
  }
  
  func testDataSetNumberSection_EqualOne() {
    stubFor(contract: "ListMovie.json")
    let viewModel = UpComingListViewModel()
    let promise = expectation(description: "resultExpectation")
    viewModel.getUpCommingMovies {
      expect(viewModel.movies).toNot(beEmpty())
      expect(viewModel.numberOfSections()).to(beGreaterThanOrEqualTo(1))
      promise.fulfill()
    }
    waitForExpectations(timeout: 3, handler: nil)
  }
  
  func testDataSetNumberRowsInSection_GreatEqualOne() {
    stubFor(contract: "ListMovie.json")
    let viewModel = UpComingListViewModel()
    let promise = expectation(description: "resultExpectation")
    viewModel.getUpCommingMovies {
      expect(viewModel.movies).toNot(beEmpty())
      expect(viewModel.numRowsSection(section: 1)).to(beGreaterThanOrEqualTo(1))
      promise.fulfill()
    }
    waitForExpectations(timeout: 3, handler: nil)
  }
  
  func testDataSetValueForCellPositionOne_MatchMovieListOne() {
    stubFor(contract: "ListMovie.json")
    let viewModel = UpComingListViewModel()
    let promise = expectation(description: "resultExpectation")
    viewModel.getUpCommingMovies {
      expect(viewModel.movies).toNot(beEmpty())
      expect(viewModel.movies.first).toNot(beNil())
      if let firstPosition = viewModel.movies.first {
        let pos = viewModel.valueForCellPosition(indexPath: IndexPath(item: 0, section: 0))?.idM ?? 0
        expect(pos).to(equal(firstPosition.idM))
      }
      promise.fulfill()
    }
    waitForExpectations(timeout: 3, handler: nil)
  }
  
  
  
//  func testGetMovieInfo_expectationResultInfo() {
//    stubFor(contract: "ListMovie.json")
//    let upcommingMovieApi: UpComingListApiProtocol = UpComingListApi()
//    let promise = expectation(description: "resultExpectation")
//    upcommingMovieApi.requestMovies(page: 0) { resultInfo in
//      expect(resultInfo.result).to(beAKindOf(PaginationModelCodable<MoviesModelCodable>.self))
//      expect(resultInfo.result?.results?.first).toNot(beNil())
//      promise.fulfill()
//    }
//    waitForExpectations(timeout: 3, handler: nil)
//  }
//  
//  func testRequestMovies_expectationResultInfo_ContractNulls() {
//    stubFor(contract: "ListMovieRequired.json")
//    let upcommingMovieApi: UpComingListApiProtocol = UpComingListApi()
//    let promise = expectation(description: "resultExpectation")
//    upcommingMovieApi.requestMovies(page: 0) { resultInfo in
//      expect(resultInfo.result).to(beAKindOf(PaginationModelCodable<MoviesModelCodable>.self))
//      expect(resultInfo.result?.results?.first).toNot(beNil())
//      promise.fulfill()
//    }
//    waitForExpectations(timeout: 3, handler: nil)
//  }
//  
//  func testRequestGenres_expectationResultInfo() {
//    stubFor(contract: "Genre.json")
//    let upcommingMovieApi: UpComingListApiProtocol = UpComingListApi()
//    let promise = expectation(description: "resultExpectation")
//    upcommingMovieApi.requestGenres { resultInfo in
//      expect(resultInfo.result).to(beAKindOf(GenreListModelCodable.self))
//      expect(resultInfo.result).toNot(beNil())
//      promise.fulfill()
//    }
//    waitForExpectations(timeout: 3, handler: nil)
//  }
//  
//  func testRequestMovieDetail_expectationResultInfo() {
//    stubFor(contract: "MovieDetail.json")
//    let upcommingMovieApi: UpComingListApiProtocol = UpComingListApi()
//    let promise = expectation(description: "resultExpectation")
//    if let object = objectForContract(contract: "ListMovie", PaginationModelCodable<MoviesModelCodable>.self) {
//      if let movie = object.results?.first {
//        upcommingMovieApi.requestMoviesDetail(movie: movie) { resultInfo in
//          expect(resultInfo.result).to(beAKindOf(MoviesDetailModelCodable.self))
//          expect(resultInfo.result).toNot(beNil())
//          promise.fulfill()
//        }
//      }
//    }
//    waitForExpectations(timeout: 3, handler: nil)
//  }
  
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
