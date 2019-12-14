//
//  MarvelConfig.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 04/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

struct MarvelConfig {
    static let privateKey = "bbf4935a33e5c40fe1112d56c8b318b1e0c709d4"
    static let publicKey = "a814ca762d721250031db0160fa2efcf"
    static let time = Date().timeIntervalSince1970.description
    static let hash: String = "\(time)\(privateKey)\(publicKey)".md5()
    
    static func asURLQueryitems() -> [URLQueryItem] {
        return [
            URLQueryItem(name: "apikey", value: MarvelConfig.publicKey),
            URLQueryItem(name: "ts", value: MarvelConfig.time),
            URLQueryItem(name: "hash", value: MarvelConfig.hash)
        ]
    }
}
