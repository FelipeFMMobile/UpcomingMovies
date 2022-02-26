//
//  UpComingMoviesKIFTests.swift
//  UpComingMoviesKIFTests
//
//  Created by Felipe Menezes de Moura on 18/07/19.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import XCTest

class UpComingMoviesKIFTests: IntegrationKIFTestCase {
    func testRXVersionButtonExists() {
        XCTAssertNotNil(viewTester().usingLabel("RXVersion"))
    }
    
    func testSwiftUIVersionButtonExists() {
        XCTAssertNotNil(viewTester().usingLabel("SwiftUI"))
    }
}
