//
//  ImageTest.swift
//  MarvelAppTests
//
//  Created by Homero Oliveira on 07/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import XCTest
@testable import MarvelApp

final class ImageTest: XCTestCase {
    func testImageJoinUrl() {
        let image = Image(path: "test", extension: "png")
        XCTAssertEqual(image.urlString, "test.png")
    }
}
