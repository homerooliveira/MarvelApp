//
//  MarvelApi.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 04/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

enum URLError: Error {
    case invalidURL
}

enum MarvelApi {
    case characters(offset: Int)
}

extension MarvelApi {
    static let baseUrl = "https://gateway.marvel.com:443"
    static let apiKey = "api_key=a814ca762d721250031db0160fa2efcf"
    
    
    func makeUrl() throws -> URL {
        let url: URL?
        switch self {
        case .characters(let offset):
            url = URL(string: "\(MarvelApi.baseUrl)/v1/public/characters?offset=\(offset)&\(MarvelApi.apiKey)")
        }
        
        guard let unwrapedUrl = url else {
            throw URLError.invalidURL
        }
        return unwrapedUrl
    }
    
    var decodableType: Decodable.Type {
        switch self {
        case .characters:
            return CharacterDataWrapper.self
        }
    }
}
