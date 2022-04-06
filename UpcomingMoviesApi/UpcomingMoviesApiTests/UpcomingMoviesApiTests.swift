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
}
