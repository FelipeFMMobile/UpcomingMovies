//
//  UpComingMoviesKIFTests.swift
//  UpComingMoviesKIFTests
//
//  Created by Felipe Menezes de Moura on 18/07/19.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import XCTest

class UpComingMoviesKIFTests: IntegrationKIFTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRXVersionButtonExists() {
        
        XCTAssertNotNil(viewTester().usingLabel("RX Version"))
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
