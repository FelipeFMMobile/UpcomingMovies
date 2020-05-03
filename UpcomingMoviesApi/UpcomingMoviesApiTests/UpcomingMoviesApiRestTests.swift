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

class UpcomingMoviesApiRestTests: XCTestCase {

  override func setUp() {
    HTTPStubs.setEnabled(true)
    HTTPStubs.onStubActivation { (request: URLRequest, stub: HTTPStubsDescriptor, _: HTTPStubsResponse) in
      print("[OHHTTPStubs] Request to \(request.url!) has been stubbed with \(String(describing: stub.name))")
    }
  }

  override func tearDown() {
      HTTPStubs.removeAllStubs()
  }

  func testNovaApiRequest_MockGenreList_True() {
    
    stub(condition: isPath("api.themoviedb.org/3/genre/movie/list?api_key=1f54bd990f1cdfb230adb312546d765d")) { _ in
      let stubPath = OHPathForFile("Genre.json", type(of: self))
      return fixture(filePath: stubPath!, status: 200, headers: ["Content-Type": "application/json"])
    }
    
    let api: ApiRestGetProtocol = ApiRest()
    let promise = expectation(description: "Api Request")
   
    let checkUrl = "https://api.themoviedb.org/3/genre/movie/list?api_key=1f54bd990f1cdfb230adb312546d765d"
    let params = ["api_key": "1f54bd990f1cdfb230adb312546d765d"]
    api.get(endPoint: UpcomingEndpoints.genres.rawValue, 
            params: params) {(sucesso: Bool, result: GenreList?, request: URLRequest?, _: NSError?) in
              XCTAssert(sucesso)
              XCTAssert(request?.url?.absoluteString == checkUrl)
              XCTAssert(result != nil)
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
