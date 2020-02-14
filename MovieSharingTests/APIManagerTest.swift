//
//  APIManagerTest.swift
//  MovieSharingTests
//
//  Created by Bhargow on 12.02.20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import XCTest
@testable import MovieSharing

class APIManagerTest: XCTestCase {

    //Test for following results
    /*
     getMethod :
     1- should return results dictionary in completionHandler when all the parameters are given correctly.
     2- should return invalidURL error in errorOccoured when wrong url is given.
     3- should return invalidResponse error in errorOccoured when url with wrong end point is given.
     */
    
    
    var apiManager: MSAPIManager!
    
    override func setUp() {
        apiManager = MSAPIManager()
    }

    override func tearDown() {
        apiManager = nil
    }

    func testApiManagerWithCorrectParameters() {
        let correctParametersExpectations = XCTestExpectation.init(description: "correctParametersExpectations")
        let parameters : [APIParameters : Any] = [.responseContentType : "Snippet",
                                           .searchKeyWord : "Movies 2020",
                                           .maxResults : maxResults,
                                           .apiKey : APIKey]
        var baseUrlString = baseUrl
        apiManager.get(urlString: &baseUrlString, urlParameters: parameters, completionHandler: { (responseDict) in
            XCTAssertNotNil(responseDict)
            correctParametersExpectations.fulfill()
        }) { (error) in
            XCTAssertNil(error)
            correctParametersExpectations.fulfill()
        }
        wait(for: [correctParametersExpectations], timeout: 10)
    }
    
    func testApiManagerWithCorrectURLWithNoParameters() {
        let noParametersExpectations = XCTestExpectation.init(description: "NoParametersExpectations")
        var baseUrlString = baseUrl
        apiManager.get(urlString: &baseUrlString, urlParameters: [:], completionHandler: { (responseDict) in
            XCTAssertTrue(responseDict.keys.contains("error"))
            noParametersExpectations.fulfill()
        }) { (error) in
            XCTAssertNil(error)
            noParametersExpectations.fulfill()
        }
        wait(for: [noParametersExpectations], timeout: 10)
    }

    func testApiManagerWithWrongURL() {
        var baseUrlString = ""
        let wrongURLExpectations = XCTestExpectation.init(description: "wrongURLExpectations")
        apiManager.get(urlString: &baseUrlString, urlParameters: [:], completionHandler: { (responseDict) in
            XCTAssertNotNil(responseDict)
            wrongURLExpectations.fulfill()
        }) { (error) in
            XCTAssertNotNil(error)
            XCTAssertEqual(error, .invalidURL)
            wrongURLExpectations.fulfill()
        }
        wait(for: [wrongURLExpectations], timeout: 10)
    }
    
    func testApiManagerWithValidURLButNoEndPoint() {
        let noEndPointExpectations = XCTestExpectation.init(description: "noEndPointExpectations")
        var baseUrlString = "http://google.com"
        apiManager.get(urlString: &baseUrlString, urlParameters: [:], completionHandler: { (responseDict) in
            XCTAssertNil(responseDict)
            noEndPointExpectations.fulfill()
        }) { (error) in
            XCTAssertNotNil(error)
            XCTAssertEqual(error, .urlSessionError)
            noEndPointExpectations.fulfill()
        }
        wait(for: [noEndPointExpectations], timeout: 10)
    }
    
    func testApiManagerForInvalidJsonFormat() {
        let invalidJsonFormatExpectations = XCTestExpectation.init(description: "invalidJsonFormat")
        var baseUrlString = "https://www.flickr.com/services/feeds/photos_public.gne?format=json"
        apiManager.get(urlString: &baseUrlString, urlParameters: [:], completionHandler: { (responseDict) in
            XCTAssertTrue(responseDict.keys.contains("error"))
            invalidJsonFormatExpectations.fulfill()
        }) { (error) in
            XCTAssertNotNil(error)
            XCTAssertEqual(error, .invalidDataFormat)
            invalidJsonFormatExpectations.fulfill()
        }
        wait(for: [invalidJsonFormatExpectations], timeout: 10)
    }
}
