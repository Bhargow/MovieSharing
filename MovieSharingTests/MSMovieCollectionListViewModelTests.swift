//
//  MSMovieCollectionListViewModelTests.swift
//  MovieSharingTests
//
//  Created by Bhargow on 12.02.20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import XCTest

class MSMovieCollectionListViewModelTests: XCTestCase {
    
    var movieListViewModel: MSMovieListViewModel!

    let gettingMoviesListExpectations = XCTestExpectation.init(description: "gettingMoviesListExpectations")
    var errorString: String!
    
    override func setUp() {
    }
    
    override func tearDown() {
        movieListViewModel = nil
        errorString = ""
    }
    
    func testGetNumberOfRows() {
        movieListViewModel = MSMovieListViewModel(delegate: self)
        XCTAssertEqual(movieListViewModel.getNumberOfRows(), 0)
    }
    
    func testGetNumberOfRowsAfterGettingMoviesList() {
        movieListViewModel = MSMovieListViewModel(delegate: self)
        movieListViewModel.getMovieList()
        wait(for: [gettingMoviesListExpectations], timeout: 10)
        XCTAssertEqual(movieListViewModel.getNumberOfRows(), 25)
    }
    
    func testWithCorrectURLWithNoParameters() {
        movieListViewModel = MSMovieListViewModel(delegate: self)
        movieListViewModel.getMovieList(urlStr: baseUrl, with: [:])
        wait(for: [gettingMoviesListExpectations], timeout: 10)
        XCTAssertEqual(errorString, "Required parameter: part")
    }
    
    func testWithWrongURL() {
        movieListViewModel = MSMovieListViewModel(delegate: self)
        movieListViewModel.getMovieList(urlStr: "", with: [:])
        wait(for: [gettingMoviesListExpectations], timeout: 10)
        XCTAssertEqual(errorString, "Invalid URL")
    }
    
    func testWithValidURLButNoEndPoint() {
        movieListViewModel = MSMovieListViewModel(delegate: self)
        movieListViewModel.getMovieList(urlStr: "http://google.com", with: [:])
        wait(for: [gettingMoviesListExpectations], timeout: 10)
        XCTAssertEqual(errorString, "Invalid Response")
    }
    
    func testWithInvalidJsonFormat() {
        movieListViewModel = MSMovieListViewModel(delegate: self)
        movieListViewModel.getMovieList(urlStr: "https://www.flickr.com/services/feeds/photos_public.gne?format=json", with: [:])
        wait(for: [gettingMoviesListExpectations], timeout: 10)
        XCTAssertEqual(errorString, "Invalid Data Format")
    }
}

extension MSMovieCollectionListViewModelTests: MSMovieCollectionViewModelDelegate {
    func refreshViews() {
        self.gettingMoviesListExpectations.fulfill()
    }
    
    func showError(_ error: String) {
        errorString = error
        self.gettingMoviesListExpectations.fulfill()
    }
}
