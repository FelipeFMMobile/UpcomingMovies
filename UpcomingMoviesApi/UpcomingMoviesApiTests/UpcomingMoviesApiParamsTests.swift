//
//  UpcomingMoviesApiTests.swift
//  UpcomingMoviesApiTests
//
//  Created by FMMobile on 19/05/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import XCTest
@testable import UpcomingMoviesApi

class UpcomingMoviesApiParamsTests: XCTestCase {
    func testJsonParams_BuildRequest_True() {
        guard let url = URL(string: "http://google.com") else {
            XCTFail("url error")
            return
        }
        var request = URLRequest(url: url)
        let params: ParamsProtocol = JsonBodyParams(params: ["teste": 123, "item": "xpto"])
        request = params.buildParams(request: request)
        if let dataBody = request.httpBody {
            let jsonString = String(data: dataBody, encoding: .utf8)
            XCTAssert(jsonString == "{\"teste\":123,\"item\":\"xpto\"}"
                      || jsonString == "{\"item\":\"xpto\",\"teste\":123}")
        }
    }

    func testGetParams_BuildRequest_True() {
        guard let url = URL(string: "http://google.com") else {
            XCTFail("url error")
            return
        }
        var request = URLRequest(url: url)
        let params: ParamsProtocol = GetParams(params: ["teste": 123, "item": "xpto"])
        request = params.buildParams(request: request)
        if let urlRequest = request.url {
            XCTAssert(urlRequest.absoluteString == "http://google.com?teste=123&item=xpto"
                      || urlRequest.absoluteString == "http://google.com?item=xpto&teste=123")
        }
    }

    func testGetParams_UrlEncode_True() {
        let params = QueryItensConvert()
        guard var url = URL(string: "http://google.com") else {
            XCTFail("url error")
            return
        }
        url = params.queryItens(url: url, params: ["teste": 123, "item": "xpto"])
        XCTAssert(url.absoluteString == "http://google.com?teste=123&item=xpto"
                  || url.absoluteString == "http://google.com?item=xpto&teste=123")
        url = params.queryItens(url: url, params: ["teste": 123])
        XCTAssertEqual(url.absoluteString, "http://google.com?teste=123")
    }

    func testGetParams_UrlEncodeObject_True() {
        let params = QueryItensConvert()
        guard var url = URL(string: "http://google.com") else {
            XCTFail("url error")
            return
        }
        url = params.queryItens(url: url, params: ["teste": NSNumber(100)])
        XCTAssertEqual(url.absoluteString, "http://google.com?teste=100")
    }

    func testGetParams_UrlEncodeInt_True() {
        let params = QueryItensConvert()
        guard var url = URL(string: "http://google.com") else {
            XCTFail("url error")
            return
        }
        url = params.queryItens(url: url, params: ["teste": Int(123)])
        XCTAssert(url.absoluteString == "http://google.com?teste=123")
    }

    func testGetParams_UrlEncodeDouble_True() {
        let params = QueryItensConvert()
        guard var url = URL(string: "http://google.com") else {
            XCTFail("url error")
            return
        }

        url = params.queryItens(url: url, params: ["teste": Double(12.20)])
        XCTAssert(url.absoluteString == "http://google.com?teste=12.2")
    }

    func testGetParams_UrlEncodeDoublePrecision_True() {
        let params = QueryItensConvert()
        guard var url = URL(string: "http://google.com") else {
            XCTFail("url error")
            return
        }

        url = params.queryItens(url: url, params: ["teste": Double(12.189)])
        XCTAssert(url.absoluteString == "http://google.com?teste=12.189")
    }

    func testGetParams_UrlEncodeFloat_True() {
        let params = QueryItensConvert()
        guard var url = URL(string: "http://google.com") else {
            XCTFail("url error")
            return
        }

        url = params.queryItens(url: url, params: ["teste": Float(12.189)])
        XCTAssert(url.absoluteString == "http://google.com?teste=12.189")
    }

    func testGetParams_UrlEncodeCharacter_True() {
        let params = QueryItensConvert()
        guard var url = URL(string: "http://google.com") else {
            XCTFail("url error")
            return
        }

        url = params.queryItens(url: url, params: ["teste": Character("u")])
        XCTAssert(url.absoluteString == "http://google.com?teste=u")
    }
}
