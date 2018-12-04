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
    
    var path: String {
        switch self {
        case .characters:
            return "\(MarvelApi.baseUrl)/v1/public/characters"
        }
    }
    
    var queryItems: [URLQueryItem] {
        var queryItems: [URLQueryItem] = MarvelConfig.asURLQueryitems()
        switch self {
        case .characters(let offset):
            queryItems.append(URLQueryItem(name: "offset", value: offset.description))
        }
        return queryItems
    }
    
    var decodableType: Decodable.Type {
        switch self {
        case .characters:
            return CharacterDataWrapper.self
        }
    }
    
    func makeUrl() throws -> URL {
        var components = URLComponents(string: path)
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            throw URLError.invalidURL
        }
        
        return url
    }
    
}
