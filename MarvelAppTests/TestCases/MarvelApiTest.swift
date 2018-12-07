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
        XCTAssertEqual(url.path, "/v1/public/characters")
        XCTAssertEqual(url.query?.contains("offset=12"), true)
    }
    
    func testComics() throws {
        let url = try MarvelApi.comics(characterId: 1, offset: 12).makeUrl()
        XCTAssertEqual(url.scheme, "https")
        XCTAssertEqual(url.host, "gateway.marvel.com")
        XCTAssertEqual(url.path, "/v1/public/characters/1/comics")
        XCTAssertEqual(url.query?.contains("offset=12"), true)
    }
}
