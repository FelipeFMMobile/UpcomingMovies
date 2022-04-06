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

class UpComingListApiTests: XCTestCase {
    
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
    
    func stubFor(contract: String) {
        stub(condition: isHost("api.themoviedb.org")) { _ in
            let stubPath = OHPathForFile(contract, type(of: self))
            return fixture(filePath: stubPath!, status: 200, headers: ["Content-Type": "application/json"])
        }
    }
    
    func testRequestMovies_expectationResultInfo() {
        stubFor(contract: "ListMovie.json")
        let upcommingMovieApi: UpComingListApiProtocol = UpComingListApi()
        let promise = expectation(description: "resultExpectation")
        upcommingMovieApi.requestMovies(page: 0) { result in
            switch result {
            case .success(let model):
                expect(model).to(beAKindOf(PaginationModelCodable<MoviesModelCodable>.self))
                expect(model.results?.first).toNot(beNil())
            case .failure(let error):
                XCTFail(error.localizedDescription)
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
            case .failure(let error):
                XCTFail(error.localizedDescription)
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
            case .failure(let error):
                XCTFail(error.localizedDescription)
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
                    case .failure(let error):
                        XCTFail(error.localizedDescription)
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
