//
//  XCTestCase.swift
//  MarvelAppTests
//
//  Created by Homero Oliveira on 05/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    func loadFile(forResource: String, withExtension: String) throws -> Data {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: forResource, withExtension: withExtension)!
        return try Data(contentsOf: url)
    }
    
    func mockSession() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }
}
