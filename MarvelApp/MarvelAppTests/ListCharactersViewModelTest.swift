//
//  ListCharactersViewModelTest.swift
//  MarvelAppTests
//
//  Created by Homero Oliveira on 05/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import XCTest
@testable import MarvelApp

final class ListCharactersViewModelTest: XCTestCase {

    var viewModel: ListCharactersViewModel!
    
    override func setUp() {
        let urlSession = mockSession()
        let marvelApiProvider = MarvelApiProvider(session: urlSession)
        let imageProvider = ImageLoader()
        
        viewModel = ListCharactersViewModel(marvelApiProvider: marvelApiProvider, imageLoader: imageProvider)
    }

    func testInitialFetch() throws {
        let mockJSONData = try loadFile(forResource: "firstPage", withExtension: "json")
        MockURLProtocol.requestHandler = { (request) in
            XCTAssertEqual(request.url?.query?.contains("offset=0"), true)
            return (HTTPURLResponse(), mockJSONData)
        }
        
        let expectation = XCTestExpectation(description: "fetchCharacters")
        
        viewModel.fetchCharacters { (state) in
            let expectedValue = ChangeState.initial
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertEqual(state, expectedValue)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
}
