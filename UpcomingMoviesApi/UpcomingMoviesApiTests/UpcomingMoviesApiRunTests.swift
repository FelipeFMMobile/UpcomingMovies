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
    OHHTTPStubs.setEnabled(true)
    OHHTTPStubs.onStubActivation { (request: URLRequest, stub: OHHTTPStubsDescriptor, _: OHHTTPStubsResponse) in
      print("[OHHTTPStubs] Request to \(request.url!) has been stubbed with \(String(describing: stub.name))")
    }
  }

  override func tearDown() {
    OHHTTPStubs.removeAllStubs()
    super.tearDown()
  }

  func testNovaApiRequest_MockGenreList_True() {
    
    stub(condition: isHost("api.themoviedb.org")) { _ in
      let stubPath = OHPathForFile("Genre.json", type(of: self))
      return fixture(filePath: stubPath!, status: 200, headers: ["Content-Type": "application/json"])
    }
    
    let api: ApiRestProtocol = ApiRunner()
    let promise = expectation(description: "Api Request")
    
    guard let url = URL(string: "http://api.themoviedb.org") else { return }
    let params = GetParams(params: [:])
    
    api.run(method: HttpMethod.GET,
                    ContentType.json,
                    endPoint: "",
                    params: params) { (sucesso: Bool, result: GenreList?, _: URLRequest?, _: NSError?) in
                      XCTAssert(sucesso)
                      XCTAssert(result != nil)
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
    
    guard let url = URL(string: "http://api.themoviedb.org") else { return }
    let params = GetParams(params: [:])
    
    api.run(method: HttpMethod.GET,
            ContentType.json,
            endPoint: "",
            params: params) { (_: Bool, result: GenreList?, _: URLRequest?, error: NSError?) in
                  XCTAssertTrue(error != nil)
                  XCTAssertTrue(error?.code == 500)
                  XCTAssertTrue(result == nil)
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
            params: params) { (_: Bool, result: GenreList?, _: URLRequest?, error: NSError?) in
                  XCTAssertTrue(error != nil)
                  XCTAssertTrue(error?.code == DefaultErrorCodes.responseCodableFail.rawValue)
                  XCTAssertTrue(result == nil)
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
