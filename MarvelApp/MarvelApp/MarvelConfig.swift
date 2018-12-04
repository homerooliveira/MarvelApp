//
//  MarvelConfig.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 04/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation
import CryptoSwift

struct MarvelConfig {
    let ts: TimeInterval
    let publicKey = MarvelConfigGenerator.publicKey
    let hash: String
}

struct MarvelConfigGenerator {
    static let privateKey = ""
    static let publicKey = ""
    
    static func hash() -> MarvelConfig {
        let time = Date().timeIntervalSince1970
        let hash = "\(time)\(privateKey)\(publicKey)".md5()
        return MarvelConfig(ts: time, hash: hash)
    }
}
