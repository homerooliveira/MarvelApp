//
//  MarvelApiProviderTest.swift
//  MarvelAppTests
//
//  Created by Homero Oliveira on 05/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import XCTest
@testable import MarvelApp

final class MarvelApiProviderTest: XCTestCase {

    var marvelApiProvider: MarvelApiProvider!
    
    override func setUp() {
        let urlSession = mockSession()
        marvelApiProvider = MarvelApiProvider(session: urlSession)
    }
    
    func testFecthOfCharacters() throws {
        let image = Image(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", extension: "jpg")
        let characters = [MarvelApp.Character(id: 1011334, name: "3-D Man", description: "", thumbnail: image)]
        let data = DataContainer(offset: 0, limit: 1, total: 1491, count: 1, results: characters)
        let expectedValue = DataWrapper(data: data)
        
        let target = MarvelApi.characters(offset: 0)
        
        let mockJSONData = try loadFile(forResource: "firstPage", withExtension: "json")
        
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.url?.query?.contains("offset=0"), true)
            return (HTTPURLResponse(), mockJSONData)
        }
        
        let expectation = XCTestExpectation(description: "fetch characters")
        
        marvelApiProvider.request(for: target) { (result: Result<DataWrapper<MarvelApp.Character>>) in
            XCTAssertEqual(expectedValue, result.value)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

}
