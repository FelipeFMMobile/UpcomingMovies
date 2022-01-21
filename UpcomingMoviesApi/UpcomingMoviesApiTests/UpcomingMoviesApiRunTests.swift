//
//  UpcomingMoviesApiTests.swift
//  UpcomingMoviesApiTests
//
//  Created by FMMobile on 19/05/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import XCTest
@testable import UpcomingMoviesApi
import OHHTTPStubs

class UpcomingMoviesApiExecuteTests: XCTestCase {
    override func setUp() {
        HTTPStubs.setEnabled(true)
        HTTPStubs.onStubActivation { (request: URLRequest, stub: HTTPStubsDescriptor, _: HTTPStubsResponse) in
            print("[OHHTTPStubs] Request to \(request.url!) has been stubbed with \(String(describing: stub.name))")
        }
    }

    override func tearDown() {
        HTTPStubs.removeAllStubs()
        super.tearDown()
    }

    func testNovaApiRequest_MockGenreList_True() {
        stub(condition: isHost("api.themoviedb.org")) { _ in
            let stubPath = OHPathForFile("Genre.json", type(of: self))
            return fixture(filePath: stubPath!, status: 200, headers: ["Content-Type": "application/json"])
        }

        let api: ApiRestProtocol = ApiRunner()
        let promise = expectation(description: "Api Request")

        let params = GetParams(params: [:])
        api.run(param: ApiParamFactory.basic.generate(endPoint: "", params: params),
                GenreList.self) { result, request in
            switch result {
            case .success(let model):
                XCTAssertTrue(!model.genres.isEmpty)
                XCTAssert(request != nil)
            case .failure:
                XCTFail("Failure not allowed")
            }
            promise.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testNovaApiRequest_Status500_True() {
        stub(condition: isHost("api.themoviedb.org")) { _ in
            let stubPath = OHPathForFile("Genre.json", type(of: self))
            return fixture(filePath: stubPath!, status: 500, headers: ["Content-Type": "application/json"])
        }

        let api: ApiRestProtocol = ApiRunner()
        let promise = expectation(description: "Api Request")
        let params = GetParams(params: [:])
        api.run(param: ApiParamFactory.basic.generate(endPoint: "",
                                                      params: params), GenreList.self) { result, _ in
            switch result {
            case .success:
                XCTFail("Failure not allowed")
            case .failure(let error):
                XCTAssertTrue(error.code == 500)
            }
            promise.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testNovaApiRequest_MockGenreListError_True() {
        stub(condition: isHost("api.themoviedb.org")) { _ in
            let stubPath = OHPathForFile("GenreCorrupt.json", type(of: self))
            return fixture(filePath: stubPath!, status: 200, headers: ["Content-Type": "application/json"])
        }

        let api: ApiRestProtocol = ApiRunner()
        let promise = expectation(description: "Api Request")
        let params = GetParams(params: [:])
        api.run(param: ApiParamFactory.basic.generate(endPoint: "",
                                                      params: params), GenreList.self) { result, _ in
            switch result {
            case .success:
                XCTFail("Failure not allowed")
            case .failure(let error):
                XCTAssertTrue(error.code == ApiErrorCodes.responseCodableFail.rawValue)
            }
            promise.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
