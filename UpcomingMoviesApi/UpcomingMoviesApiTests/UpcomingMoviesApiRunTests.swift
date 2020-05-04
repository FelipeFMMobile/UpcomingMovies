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
    
    guard let _ = URL(string: "http://api.themoviedb.org") else { return }
    let params = GetParams(params: [:])
    
    api.run(method: HttpMethod.GET,
                    ContentType.json,
                    endPoint: "",
                    params: params) { (response: Result<ResultRequest<GenreList>, NSError>) in
                        switch response {
                        case .success(let result):
                            XCTAssertNotNil(result.data)
                        case .failure:
                            XCTFail()
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
    
    guard let _ = URL(string: "http://api.themoviedb.org") else { return }
    let params = GetParams(params: [:])
    
    api.run(method: HttpMethod.GET,
            ContentType.json,
            endPoint: "",
            params: params) { (response: Result<ResultRequest<GenreList>, NSError>)  in
                switch response {
                case .success(let result):
                    XCTFail()
                    XCTAssertNotNil(result.data)
                case .failure(let error):
                    XCTAssertEqual(error.code, 500)
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
    
    guard let url = URL(string: "http://api.themoviedb.org") else { return }
    let params = GetParams(params: [:])
    
    api.run(method: HttpMethod.GET,
            ContentType.json,
            endPoint: "",
            params: params) { (response: Result<ResultRequest<GenreList>, NSError>) in
                   switch response {
                   case .success(let result):
                       XCTFail()
                       XCTAssertNotNil(result.data)
                   case .failure(let error):
                       XCTAssertEqual(error.code, DefaultErrorCodes.responseCodableFail.rawValue)
                   }
                   promise.fulfill()
    }
    waitForExpectations(timeout: 10, handler: nil)
    
  }

  func testPerformanceExample() {
      // This is an example of a performance test case.
      self.measure {
          // Put the code you want to measure the time of here.
      }
  }

}
