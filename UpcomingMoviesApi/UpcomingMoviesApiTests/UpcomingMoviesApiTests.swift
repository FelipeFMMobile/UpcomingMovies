//
//  UpcomingMoviesApiTests.swift
//  UpcomingMoviesApiTests
//
//  Created by FMMobile on 19/05/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import XCTest
@testable import UpcomingMoviesApi

class UpcomingMoviesApiTests: XCTestCase {
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testContentType_FormType_True() {
        let contentType = ContentType.formurlencoded.contentType()
        XCTAssert(contentType == "application/x-www-form-urlencoded")
    }
    
    func testContentType_JsonType_True() {
        let contentType = ContentType.json.contentType()
        XCTAssert(contentType == "application/json")
    }
    
    func testHttpMethod_CheckAll_True() {
        XCTAssert(HttpMethod.GET.verb() == "GET")
        XCTAssert(HttpMethod.POST.verb() == "POST")
        XCTAssert(HttpMethod.PUT.verb() == "PUT")
        XCTAssert(HttpMethod.DELETE.verb() == "DELETE")
        XCTAssert(HttpMethod.PATCH.verb() == "PATCH")
    }
    
    func testWebDomainForBundle_IsNot_Null() {
        let domain = WebDomain.domainForBundle()
        XCTAssert(domain.rawValue != "")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }    
}
