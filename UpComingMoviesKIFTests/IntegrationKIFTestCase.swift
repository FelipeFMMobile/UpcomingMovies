//
//  KIFTestCase.swift
//  UpComingMoviesKIFTests
//
//  Created by Felipe Menezes de Moura on 18/07/19.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import Foundation
import KIF
@testable import UpComingMovies

/// IntegrationTetCase - stubs and KIF functions
internal class IntegrationKIFTestCase: KIFTestCase {
    
    override func setUp() {
        super.setUp()
        // Run the test animations super fast!!!
        // KIFTypist.setKeystrokeDelay( 0.0025)
        // KIFTestActor.setDefaultAnimationStabilizationTimeout(0.1)
        // KIFTestActor.setDefaultAnimationWaitingTimeout(2.0)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
}

extension IntegrationKIFTestCase {
    func viewTester(_ file: String = #file, _ line: Int = #line) -> KIFUIViewTestActor {
        return KIFUIViewTestActor(inFile: file, atLine: line, delegate: self)
    }
    
    func system(_ file: String = #file, _ line: Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}
