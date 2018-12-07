//
//  CharacterDataWrapper.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 04/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

struct DataWrapper: Decodable, Equatable {
    let data: CharacterDataContainer
}

struct CharacterDataContainer: Decodable, Equatable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Character]
}

struct Character: Decodable, Equatable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Image
}

struct Image: Decodable, Equatable {
    let path: String
    let `extension`: String
}

extension Image {
    var urlString: String {
        return path + "." + `extension`
    }
}
