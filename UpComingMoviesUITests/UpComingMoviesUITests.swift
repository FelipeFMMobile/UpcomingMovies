//
//  UpComingMoviesUITests.swift
//  UpComingMoviesUITests
//
//  Created by Felipe Menezes on 05/03/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

import XCTest

class UpComingMoviesUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testNavigationToDetailIsRight() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        // Navigation
        app.collectionViews.firstMatch.tap()
        app.buttons["Favorito"].tap()
        app.navigationBars.firstMatch.buttons["Upcoming Movies"].tap()
        app.cells.firstMatch.swipeUp()
    }

    func testLaunchPerformance() throws {
        if #available(iOS 15.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
