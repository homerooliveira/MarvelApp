//
//  MarvelApiTest.swift
//  MarvelAppTests
//
//  Created by Homero Oliveira on 04/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import XCTest
@testable import MarvelApp

final class MarvelApiTest: XCTestCase {

    func testCharacters() throws {
        let url = try MarvelApi.characters(offset: 12).makeUrl()
        XCTAssertEqual(url.scheme, "https")
        XCTAssertEqual(url.host, "gateway.marvel.com")
        XCTAssertEqual(url.query?.contains("offset=12"), true)
    }
    
}
